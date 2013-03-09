## SVG Profiler

Profiles a Scalable Vector Graphics xml string.

## Setup

SVG Profiler depends on an open-source application called Inkscape.

```
brew install inkscape
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
```

## Contribution

If there's a metric you'd like to see implemented, please send a pull request or open an issue.
