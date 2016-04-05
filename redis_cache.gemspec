$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "redis_cache/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "redis_cache"
  s.version     = RedisCache::VERSION
  s.authors     = ["Aditia Mahdar"]
  s.email       = ["adit@41studio.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RedisCache."
  s.description = "TODO: Description of RedisCache."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"

  s.add_development_dependency "sqlite3"
end
