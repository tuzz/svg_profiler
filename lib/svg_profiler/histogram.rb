class SVGProfiler::Histogram

  WARN_THRESHOLD = 0.02

  def self.for(xml_string, png)
    new(xml_string, png).histogram
  end

  def initialize(xml_string, png)
    check_for_imagemagick
    @image = Magick::Image.read(png.path).first
    @palette = SVGPalette.parse(xml_string)
  end

  def histogram
    @image.quantize(8) # 00-FF is 8-bits.

    histogram = @image.color_histogram
    frequencies = histogram.inject({}) do |hash, (p, f)|
      hash.merge(to_hex(p) => f)
    end

    filter_by_palette!(frequencies)
    normalize(frequencies)
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

  # When the png is created, it gets anti-aliased.
  # If it is down-sampled, you'll end up with many midway colors.
  # These have a negligible pixel count and could be thresholded out.
  # This seems like a better approach, assuming the palette is correct.
  def filter_by_palette!(hash)
    hex_codes = @palette.map(&:html)
    pre_filter = normalize(hash)

    hash.reject! do |k, v|
      unless hex_codes.include?(k.downcase) || black?(k)
        warn_if_filtering_a_prominent_color(k, pre_filter)
        true
      end
    end
  end

  def warn_if_filtering_a_prominent_color(hex, normalized)
    if normalized[hex] > WARN_THRESHOLD
      puts "\n#{__FILE__}:#{__LINE__}"
      puts "WARNING: '#{hex}' was been assumed to be an artifact of anti-aliasing when perhaps it was not."
      puts "Please email your SVG to chris@patuzzo.co.uk, with a subject of `SVG Filter Threshold'."
    end
  end

  # In cases where nodes do not explicitly set a color, they will be black.
  # Therefore, do not filter out black from the histogram.
  def black?(hex)
    hex == "#000000"
  end

  def normalize(frequencies)
    sum = frequencies.values.inject(:+)
    frequencies.inject({}) do |hash, (k, v)|
      hash.merge(k => v.to_f / sum)
    end
  end

end
