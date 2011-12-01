require 'rubygems'
require 'helper'

class TestWesi < Test::Unit::TestCase

 context "Initial tests" do
	should "check that 2+2=4!" do
		assert_equal 2 + 2, 4
	end
 end
 
 context "Compare graphs" do
    setup do
	  
	 dataDir = 'data/'
	 
	 f1 = "ex1.ttl"
	 f2 = "ex2.ttl"
	 f3 = "ex2bis.ttl"

	 @g1 = RDFGraph.new
	 @g1.read(dataDir + f1)

	 @g2 = RDFGraph.new
	 @g2.read(dataDir + f2)

	 @g3 = RDFGraph.new
	 @g3.read(dataDir + f3)	
	end
	
	should "check that g1 and g2 are different" do
		assert_equal @g1 == @g2, false
	end

	should "check that g1 and g3 are different" do
		assert_equal @g1 == @g3, false
	end

	should "check that g2 and g3 are equal" do
		assert_equal @g2 == @g3, true
	end
 end

end
