class SVGProfiler

  attr_reader :xml

  def initialize(xml_string)
    @xml = Nokogiri::XML(xml_string)
  end

  def dimensions
    svg = xml.css("svg")

    width, height = %w(width height).map { |s| attribute(svg, s) }
    view_box = attribute(svg, "viewBox")

    if view_box
      _, _, v_width, v_height = view_box.split(" ")
    end

    [width || v_width, height || v_height].map(&:to_i)
  end

  def width
    dimensions.first
  end

  def height
    dimensions.last
  end

  def aspect
    width.to_f / height
  end

  private
  def attribute(node, attribute)
    a = node.attr(attribute)
    a.value if a
  end

end
