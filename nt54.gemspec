require File.expand_path("../lib/nt54/version", __FILE__)

Gem::Specification.new do |s|
  s.name          = "nt54"
  s.version       = NT54::VERSION
  s.authors       = ["Norman Clarke"]
  s.email         = ["norman@njclarke.com"]
  s.homepage      = "http://github.com/norman/nt54"
  s.summary       = "A library for working with Argentine phone numbers"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.require_paths = ["lib"]
  s.description   = "Provides Argentine phone number parsing, validation, formatting and meta-information."

  s.add_dependency "ambry"
  s.add_dependency "micromachine"
  s.add_development_dependency "minitest"
end
