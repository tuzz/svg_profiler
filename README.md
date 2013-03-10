## SVG Profiler

Profiles a Scalable Vector Graphics xml string.

## Setup

```
brew install imagemagick inkscape
gem install svg_profiler
```

## Usage

```ruby
require "svg_profiler"

profile = SVGProfiler.new(File.read("file.svg"))

profile.dimensions
#=> [900, 600]

profile.width
#=> 900

profile.height
#=> 600

profile.aspect
#=> 1.5

profile.histogram
#=> { "#FF0000" => 0.7, "#FFFFFF" => 0.29, "#000000" => 0.01 }
```

When calculating the histogram, the SVG is rasterized to a PNG and anti-aliased.

This may have a small impact on the color ratios.

## Contribution

If there's a metric you'd like to see implemented, please send a pull request or open an issue.
