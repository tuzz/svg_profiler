require "spec_helper"

describe SVGProfiler do

  describe "#dimensions" do
    it "returns an array based on the width and height of the svg node" do
      profile = SVGProfiler.new(fixture("algeria.svg"))
      profile.dimensions.should == [900, 600]

      profile = SVGProfiler.new(fixture("togo.svg"))
      profile.dimensions.should == [809, 500]
    end

    it "falls back to the viewbox attribute" do
      profile = SVGProfiler.new(fixture("seychelles.svg"))
      profile.dimensions.should == [900, 450]
    end

    it "does not break for unusual cases" do
      profile = SVGProfiler.new("<svg width='100' viewBox='-1 ??? 50 200'/>")
      profile.dimensions.should == [100, 200]

      profile = SVGProfiler.new("<svg height='50'>")
      profile.dimensions.should == [0, 50]
    end
  end

  describe "#width" do
    it "returns the width" do
      profile = SVGProfiler.new(fixture("togo.svg"))
      profile.width.should == 809
    end
  end

  describe "#height" do
    it "returns the height" do
      profile = SVGProfiler.new(fixture("seychelles.svg"))
      profile.height.should == 450
    end
  end

  describe "#aspect" do
    it "returns the width divided by the height" do
      profile = SVGProfiler.new(fixture("algeria.svg"))
      profile.aspect.should == 1.5
    end
  end

end
