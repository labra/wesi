require 'rubygems'
require 'graphviz'
require 'java'

java_import 'com.hp.hpl.jena.rdf.model.ModelFactory'
java_import 'com.hp.hpl.jena.rdf.model.Model'
java_import 'com.hp.hpl.jena.util.FileManager'
java_import 'com.hp.hpl.jena.shared.PrefixMapping'

class RDF2Gv
   def initialize(rdf_file, gv_path, format) 
      @rdf_file = rdf_file
      @model = ModelFactory.create_default_model

	  # We add common prefixes like rdf, rdfs, etc.
	  @model.withDefaultMappings(PrefixMapping.Standard)

	  file = FileManager.get.open rdf_file
	  @model.read(file, "", format)
      @graph = GraphViz.new(:RDF, :path => gv_path)
      parse
   end

   def save(format, file)
      @graph.output(format => file)
   end

   def parse
   	 anonStyle = { 
	      :shape => "circle" , 
		  :label => "", 
		  :style => :filled, 
		  :fillcolor => "blue"
		}
	 uriStyle = {
	      :shape => "ellipse"  
	 }

	 literalStyle = {
	      :shape => "polygon"  
	 }

     @model.listStatements.each { |s|
	  if s.subject.isAnon 
	   subj = @graph.add_node(s.subject.toString,anonStyle) 
	  else
	   subj = @graph.add_node(prefixName(s.subject), uriStyle)
	  end

	  if s.object.isAnon
	   obj = @graph.add_node(s.object.getId, anonStyle)
      elsif s.object.isURIResource
	   obj = @graph.add_node(prefixName(s.object), uriStyle)
      elsif s.object.isLiteral
	   lit = s.object
       obj = @graph.add_node(lit.getLexicalForm, literalStyle)
	  else 
	   throw "Unknown type of object" 
	  end
	  
	  @graph.add_edge(subj,obj,{:label => prefixName(s.predicate) })
	 }
   end
   
   def prefixName(resource)
    ns = resource.getNameSpace
	prefix = @model.getNsURIPrefix(ns)
    if prefix == nil
	 return resource.toString
	else
	 return prefix + ":" + resource.localName
	end
   end

end

