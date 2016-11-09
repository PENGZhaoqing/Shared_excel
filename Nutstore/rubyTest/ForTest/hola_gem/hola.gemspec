Gem::Specification.new do |s|
  s.name = %q{hola_gem}
  s.version = "0.0.0"
  s.date = %q{2011-09-29}
  s.summary = %q{awesome_gem is the best}
  s.description = "A simple hello world gem"
  s.email       = 'nick@quaran.to'
  s.author = ["peng"]
  s.homepage    =
    'http://rubygems.org/gems/awesome_gem'
  s.files = [
    "lib/hola.rb",
    "lib/hola/translator.rb"
  ]
  s.require_paths = ["lib"]
  s.license       = 'MIT'
  s.executables << 'hola'
end