# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_stack/version"

Gem::Specification.new do |s|
  s.name        = "simple_stack"
  s.version     = SimpleStack::VERSION
  s.authors     = ["Thiago Morello", "Willian Molinari"]
  s.email       = ["thiago.morello@locaweb.com.br", "willian.molinari@locaweb.com.br"]
  s.homepage    = "https://github.com/locaweb/ruby-simplestack-client"
  s.summary     = %q{A simple gem to work with simplestack project}
  s.description = s.summary

  s.rubyforge_project = "simple_stack"

  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_runtime_dependency "httparty"
end
