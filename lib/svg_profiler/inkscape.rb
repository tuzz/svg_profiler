class SVGProfiler::Inkscape

  def initialize(xml)
    check_for_inkscape
    @xml = xml
  end

  def width
    exec("-W").to_i
  end

  def height
    exec("-H").to_i
  end

  private
  def check_for_inkscape
    unless system("which inkscape &>/dev/null")
      raise DependencyError.new(
        "Could not locate Inkscape, try `brew install inkscape'"
      )
    end
  end

  def exec(command)
    input = Tempfile.new(["input", ".svg"])
    input.write(@xml.to_s)
    input.close

    `inkscape -z #{command} #{input.path}`
  end

  class DependencyError < StandardError; end

end
