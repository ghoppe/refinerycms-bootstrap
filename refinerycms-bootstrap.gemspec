# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-bootstrap'
  s.version           = '3.2.0.0'
  s.author            = 'Glenn Hoppe'
  s.description       = 'Ruby on Rails Bootstrap extension for Refinery CMS'
  s.date              = '2013-09-09'
  s.summary           = 'Bootstrap extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency    'refinerycms-core',     '~> 3.0.0.dev'
  s.add_dependency    'refinerycms-images',   '~> 3.0.0.dev'
  s.add_dependency    'bootstrap-sass', '~> 3.2.0'
end
