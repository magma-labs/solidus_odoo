# encoding: UTF-8

$:.push File.expand_path('../lib', __FILE__)
require 'solidus_odoo/version'

Gem::Specification.new do |s|
  s.name        = 'solidus_odoo'
  s.version     = SolidusOdoo::VERSION
  s.summary     = 'This summary is very well detailed'
  s.description = 'This is a extention is for a solidus integration with odoo'
  s.license     = 'BSD-3-Clause'
  s.authors     = ['Alberto Mendoza', 'Mumo Carlos']
  s.email       = ['alberto.mendoza@magmalabs.io', 'mumo.crls@gmail.com']

  s.files = Dir["{app,config,db,lib}/**/*", 'LICENSE', 'Rakefile', 'README.md']
  solidus_version = ['>= 1.0', '< 3']

  s.add_dependency 'solidus_core', solidus_version
  s.add_dependency 'solidus_backend', solidus_version
  s.add_dependency 'solidus_api', solidus_version
  s.add_dependency 'solidus_support'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pry-rails'
end
