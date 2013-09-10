# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-bootstrap'
  s.version           = '2.1.0'
  s.author            = 'Glenn Hoppe'
  s.description       = 'Ruby on Rails Bootstrap extension for Refinery CMS'
  s.date              = '2013-08-07'
  s.summary           = 'Bootstrap extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.1.0'
  s.add_dependency             'refinerycms-images',  '~> 2.1.0'
  s.add_runtime_dependency     'bootstrap-sass',      '>= 2.3.2.1'
end
