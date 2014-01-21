$:.push File.expand_path("../lib", __FILE__)

require "neutral/version"

Gem::Specification.new do |s|
  s.name        = "neutral"
  s.version     = Neutral::VERSION
  s.authors     = ["Peter Tóth"]
  s.email       = ["proximin@gmail.com"]
  s.homepage    = "https://github.com/petertoth/neutral"
  s.summary     = "Rails engine providing positive/negative ajaxful voting solution with FontAwesome integration and handful of additional features."
  s.description = "Rails engine providing positive/negative ajaxful voting solution with FontAwesome integration and handful of additional features."

  s.files = `git ls-files`.split("\n") - Dir["images/*"]
  s.test_files = `git ls-files -- spec/**/*`.split("\n")

  s.add_dependency "rails", "~> 4.0.0"
	s.add_dependency "font-awesome-rails", "~> 4.0.3.1"
	s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "ffaker"
  s.add_development_dependency "therubyracer"
  s.add_development_dependency "sorcery"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl_rails", "~> 4.2.1"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "remarkable_activerecord"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "debugger"
end
