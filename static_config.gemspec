# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "static_config/version"

Gem::Specification.new do |s|
  s.name        = "static_config"
  s.version     = StaticConfig::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Burke"]
  s.email       = ["spraints@gmail.com"]
  s.homepage    = "http://github.com/spraints/static_config"
  s.summary     = %q{Load configuration from yaml and/or environment variables}
  s.description = %q{Load configuration from yaml and/or environment variables}

  s.rubyforge_project = "static_config"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
