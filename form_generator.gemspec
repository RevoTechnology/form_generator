$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "form_generator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "form_generator"
  s.version     = FormGenerator::VERSION
  s.authors     = ["Max Bulgakov"]
  s.email       = ["madmacj@gmail.com"]
  s.homepage    = "http://gems.theteam.io/"
  s.summary     = "Generator of HTML forms from YAML source."
  s.description = "A gem for NetSmarts system, for generating forms with different stuff."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2.2"
  s.add_dependency 'mysql2'

  s.add_dependency 'sass-rails',   '>= 3.2.5'
  s.add_dependency 'coffee-rails', '>= 3.2.2'
  s.add_dependency 'uglifier', '>= 1.2.4'
  s.add_dependency 'therubyracer'

  s.add_dependency 'dbf'
  s.add_dependency 'awesome_nested_set'
  s.add_dependency 'haml'
  s.add_dependency 'unicorn'


  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'capistrano'
  s.add_development_dependency 'capistrano-ext'
  s.add_development_dependency 'rvm-capistrano'
  s.add_development_dependency 'capistrano_colors'

end
