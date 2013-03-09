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

# The #colors method calculates the histogram for the SVG.
profile.colors
#=> { "#FF0000" => 0.7, "#FFFFFF" => 0.29, "#000000" => 0.01 }
```

You may find that the SVG is [antialiased](http://en.wikipedia.org/wiki/Spatial_anti-aliasing) before the histogram is calculated.

You can pass an optional threshold to the `#colors` method, to help cope with this:

```ruby
profile.colors(0.02)
#=> { "#FF0000" => 0.7070707070707071, "#FFFFFF" => 0.29292929292929293 }
```

The sum of the values in the hash will always add up to one.

## Contribution

If there's a metric you'd like to see implemented, please send a pull request or open an issue.
