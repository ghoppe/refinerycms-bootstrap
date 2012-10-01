# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-bootstrap'
  s.version           = '2.1.0.dev'
  s.author            = 'Glenn Hoppe'
  s.description       = 'Ruby on Rails Bootstrap extension for Refinery CMS'
  s.date              = '2012-07-31'
  s.summary           = 'Bootstrap extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.0'
  s.add_dependency             'refinerycms-images',  '~> 2.0'
  s.add_dependency             'bootstrap-sass',      '~> 2.1.0.1'
end
