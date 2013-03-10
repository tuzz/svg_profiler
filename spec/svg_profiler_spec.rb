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

  describe "#histogram" do
    it "returns a histogram hash of the hex color ratios" do
      profile = SVGProfiler.new(fixture("togo.svg"))
      histogram = profile.histogram

      # For the togo flag, the ratios are roughly:
      expected_color_ratios = {
        "#006A4E" => 0.45, # green
        "#FFCE00" => 0.33, # yellow
        "#D21034" => 0.20, # red
        "#FFFFFF" => 0.02  # white
      }

      expected_color_ratios.each do |hex, ratio|
        histogram[hex].should be_within(0.01).of(ratio)
      end

      histogram.size.should == 4
    end

    it "does not filter out black" do
      profile = SVGProfiler.new(fixture("south_africa.svg"))
      histogram = profile.histogram
      histogram["#000000"].should_not be_nil, "Black is being filtered out"
    end
  end

end
