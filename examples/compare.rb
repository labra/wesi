$:.push '../lib'
require 'rdfGraph'

dataDir = '../data/'

f1 = "ex1.ttl"
f2 = "ex2.ttl"
f3 = "ex2bis.ttl"

g1 = RDFGraph.new
g1.read(dataDir + f1)

g2 = RDFGraph.new
g2.read(dataDir + f2)

g3 = RDFGraph.new
g3.read(dataDir + f3)

puts "f1,f2," + (g1 == g2).to_s
puts "f1,f3," + (g1 == g3).to_s
puts "f2,f3," + (g2 == g3).to_s