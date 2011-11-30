require 'rdfGraph'

dataDir = '../data/'

g1 = RDFGraph.new
g1.read(dataDir + "ex1.ttl")
g1.write