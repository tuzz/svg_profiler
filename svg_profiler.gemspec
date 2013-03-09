Gem::Specification.new do |s|
  s.name        = "svg_profiler"
  s.version     = "1.0.1"
  s.summary     = "SVG Profiler"
  s.description = "Profiles a Scalable Vector Graphics xml string."
  s.author      = "Chris Patuzzo"
  s.email       = "chris@patuzzo.co.uk"
  s.files       = ["README.md"] + Dir["lib/**/*.*"]
  s.homepage    = "https://github.com/cpatuzzo/svg_profiler"

  s.add_development_dependency "rspec"
end
