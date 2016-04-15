$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simple_redis/version"
require "simple_redis/constant"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simple_redis"
  s.version     = SimpleRedis::VERSION
  s.authors     = ["Aditia Mahdar"]
  s.email       = ["adit.mahdar@gmail.com"]
  s.homepage    = "https://github.com/aditiamahdar/simple_redis"
  s.summary     = "Use Simple Redis just like you use Rails cache"
  s.description = "Wrapper Gem for redis to make us easy operate cache with Redis"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "redis"

  s.add_development_dependency "rails", "~> 4.2.3"
  s.add_development_dependency "sqlite3"
end
