class SVGProfiler::Histogram

  def self.for(png, threshold)
    new(png).histogram(threshold)
  end

  def initialize(png)
    check_for_imagemagick
    @image = Magick::Image.read(png.path).first
  end

  def histogram(threshold)
    @image.quantize(8) # 00-FF is 8-bits.

    histogram = @image.color_histogram
    frequencies = histogram.inject({}) do |hash, (p, f)|
      hash.merge(to_hex(p) => f)
    end

    ratios = normalize(frequencies)
    ratios.reject! { |_, v| v < threshold }

    # Re-normalize after thresholding.
    normalize(ratios)
  end

  private
  def check_for_imagemagick
    unless system("which convert &>/dev/null")
      raise DependencyError.new(
        "Could not locate Imagemagick, try `brew install imagemagick'"
      )
    end
  end

  def to_hex(pixel)
    # The first two parameters are ignored by RMagick.
    pixel.to_color(Magick::AllCompliance, false, 8, true)
  end

  def normalize(frequencies)
    sum = frequencies.values.inject(:+)
    frequencies.inject({}) do |hash, (k, v)|
      hash.merge(k => v.to_f / sum)
    end
  end

end
