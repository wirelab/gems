Gem::Specification.new do |gem|
  gem.name = gem.summary = 'favicon'
  gem.version = '1.0.0'
  gem.require_path = 'favicon'
  gem.files = `git ls-files favicon`.split("\n")
  gem.authors = ["Tim Peters"]

  gem.add_dependency 'addressable', '~> 2.4.0'
  gem.add_dependency 'nokogiri', '~> 1.6.7'
  gem.add_dependency 'httparty', '~> 0.13.7'
end
