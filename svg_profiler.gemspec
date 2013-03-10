Gem::Specification.new do |s|
  s.name        = "svg_profiler"
  s.version     = "2.0.0"
  s.summary     = "SVG Profiler"
  s.description = "Profiles a Scalable Vector Graphics xml string."
  s.author      = "Chris Patuzzo"
  s.email       = "chris@patuzzo.co.uk"
  s.files       = ["README.md"] + Dir["lib/**/*.*"]
  s.homepage    = "https://github.com/cpatuzzo/svg_profiler"

  s.add_dependency "rmagick"
  s.add_dependency "svg_palette"

  s.add_development_dependency "rspec"
end
