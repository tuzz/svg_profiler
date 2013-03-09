require "rspec"
require "svg_profiler"

def fixture(path)
  File.read("spec/fixtures/#{path}")
end
