require 'rubygems'
require 'graphviz'
require 'java'

java_import 'com.hp.hpl.jena.rdf.model.ModelFactory'
java_import 'com.hp.hpl.jena.rdf.model.Model'
java_import 'com.hp.hpl.jena.util.FileManager'
java_import 'com.hp.hpl.jena.shared.PrefixMapping'

class RDF2Gv
   def initialize(model, gv_path) 
      @model = model
	  @gv    = GraphViz.new(:RDF, :path => gv_path)
      model2gv
   end

   def save(format, file)
      @gv.output(format => file)
   end

   def model2gv
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
	   subj = @gv.add_node(s.subject.toString,anonStyle) 
	  else
	   subjLabel = prefixName(s.subject)
	   subj = @gv.add_node(subjLabel, 
	                       uriStyle.merge({:label => subjLabel}))
	  end

	  if s.object.isAnon
	   obj = @gv.add_node(s.object.toString, anonStyle)
      elsif s.object.isURIResource
	   objLabel = prefixName(s.object)
	   obj = @gv.add_node(objLabel, 
	                      uriStyle.merge({:label => objLabel}))
      elsif s.object.isLiteral
	   litLabel = s.object.getLexicalForm
       obj = @gv.add_node(litLabel, 
					      literalStyle.merge({ :label => litLabel }))
	  else 
	   throw "Unknown type of object" 
	  end
	  
	  @gv.add_edge(subj,obj,{:label => prefixName(s.predicate) })
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

