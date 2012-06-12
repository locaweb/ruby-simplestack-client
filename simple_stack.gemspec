# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_stack/version"

Gem::Specification.new do |s|
  s.name        = "simple_stack"
  s.version     = SimpleStack::VERSION
  s.authors     = ["Thiago Morello"]
  s.email       = ["thiago.morello@locaweb.com.br"]
  s.homepage    = ""
  s.summary     = %q{A Simple Stack gem}
  s.description = %q{A Simple Stack gem}

  s.rubyforge_project = "simple_stack"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "httparty"
end
