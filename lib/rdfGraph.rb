require 'rubygems'
require 'java'
require 'rdf2gv'
#require 'rest_client'
#require 'JSON'

java_import 'java.io.ByteArrayOutputStream'
include_class 'java.io.StringReader'

java_import 'com.hp.hpl.jena.rdf.model.ModelFactory'
java_import 'com.hp.hpl.jena.rdf.model.Model'
java_import 'com.hp.hpl.jena.util.FileManager'
java_import 'com.hp.hpl.jena.shared.PrefixMapping'

java_import 'com.hp.hpl.jena.query.Query'
java_import 'com.hp.hpl.jena.query.QueryFactory'
java_import 'com.hp.hpl.jena.query.QueryExecutionFactory'



class RDFGraph

 attr_accessor :model
 
 def initialize(model = nil) 
  if model == nil
    @model = ModelFactory.create_default_model 
  else
    @model = model
  end
  
  # We add common prefixes like rdf, rdfs, etc.
  @model.withDefaultMappings(PrefixMapping.Standard)

 end
 
 def addStatement(s,p,o) 
  subj = @model.create_resource(s)
  prop = @model.create_property(p)
  obj  = @model.create_resource(o)
  subj.add_property(prop,obj)
 end

 def ==(g2)
  @model.is_isomorphic_with(g2.model)
 end

 def to_s(options = nil)
  os = ByteArrayOutputStream.new
  format  = option options, :format, "TURTLE"
  @model.write(os,format)
  return os.to_s
 end
 
 def isomorphic(g2)
  @model.is_isomorphic_with(g2.model)
 end

 def write(os = java.lang.System::out, format = 'TURTLE')
  @model.write(os, format)
 end

 def gv(out_format, out_file, gv_path = "")
  gv = RDF2Gv.new(@model,gv_path)
  gv.save(out_format,out_file)
 end
 
 def showPrefixes
  @model.getNsPrefixMap.each { |k,v|
    puts k + " -> " + v
  } 
  end

 def addPrefix(prefix,uri = nil)
  if uri == nil 
    if @lookupPrefix
	  lookupUri = "http://prefix.cc/#{prefix}.file.json"
	  resp = RestClient.get lookupUri
      json = JSON.parse(resp)
	  uri = json[prefix]
	else
	  # throw error if lookupPrefix = false && uri == nil ?
	end
  end
  @model.setNsPrefix(prefix,uri)
 end 

 def getPrefix(prefix)
  # I wanted to use @model.getNsPrefixURI(prefix) but fails, why?
  self.model.getNsPrefixURI(prefix)
 end

 def removePrefix(prefix)
  @model.removeNsPrefix(prefix)
 end
 
 def loadPrefixes
  data = File.open(@filePrefixTable).read
  prefixTable = JSON.parse(data)
  prefixTable.each { |k,v|
   @model.setNsPrefix(k,v)
  }
 end

 def parse(str)
  java_string = java.lang.String.new(str.to_java_bytes).java_object
  reader = StringReader.new(java_string)
  @model.read(reader,"","TURTLE")
 end
 
 def read(uri, format="TURTLE")
  file = FileManager.get.open uri
  @model.read(file, "", format)
 end
 
 def rdfs
  rdfs_model = ModelFactory.createRDFSModel(@modelo)
  return RDFGraph.new(rdfs_model)
 end
 
 def owl
  # TODO
 end
 
 def query(str = "SELECT * WHERE { ?s ?p ?o }",options=nil)
  q = Query.new  
  
  map = as_prefix_map(self.model.getNsPrefixMap)
  puts "Map = " + map.to_s
  q.setPrefixMapping(map)
  
  baseURI = option options, :baseURI, nil
  syntax  = option options, :syntax, com.hp.hpl.jena.query.Syntax.syntaxSPARQL_11
  
  QueryFactory.parse(q,str,baseURI,syntax)
  puts "Query = " + q.serialize
  puts "-----------------------"
  qexec = QueryExecutionFactory.create(q,@model)
  results = qexec.execSelect
  results.each { |sol| 
    sol.varNames.each { |var|
      printf(" %s -> %s |",var,sol.get(var).to_s)
    }
   puts
 } 
 end

 :private

 def as_prefix_map(map) 
  pm = com.hp.hpl.jena.shared.impl.PrefixMappingImpl.new
  map.each { |k,v| 
    pm.setNsPrefix k.to_s, v.to_s
  }
  return pm
 end
 
 def option( options, opt, default )
   if has_option?( options, opt ) then options[opt] else default end
 end

 def has_option?( options, opt )
   options && options.has_key?( opt )
 end

end

