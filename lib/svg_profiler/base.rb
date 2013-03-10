class SVGProfiler

  def initialize(xml_string)
    @xml_string = xml_string
    @inkscape = Inkscape.new(xml_string)
  end

  def width
    @inkscape.width
  end

  def height
    @inkscape.height
  end

  def dimensions
    [width, height]
  end

  def aspect
    width.to_f / height
  end

  def histogram
    @inkscape.yield_png { |png| Histogram.for(@xml_string, png) }
  end

end
