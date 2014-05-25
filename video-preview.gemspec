$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "video-preview"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "video-preview"
  s.version     = VideoPreview::VERSION
  s.authors     = ["Dmitry Filimonov"]
  s.email       = ["me@dfilimonov.com"]
  s.homepage    = "https://github.com/petethepig/video-preview"
  s.summary     = "Library that allows you to generate video previews in a wise manner."
  # s.description = "https://github.com/petethepig/video-preview"
  s.license     = "MIT"

  s.require_paths = ['lib']
  s.files = Dir["{lib}/**/*"] + ["LICENSE", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.requirements << "ImageMagick"

end