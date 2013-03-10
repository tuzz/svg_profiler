class SVGProfiler

  def initialize(xml_string)
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

  def histogram(threshold = 0)
    @inkscape.yield_png { |png| Histogram.for(png, threshold) }
  end

end
