GEM::Specification.new do |gem|
  gem.name = gem.summary = 'Favicon'
  gem.version = '1.0.0'
  gem.require_path = 'favicon'
  gem.files = `git ls-files favicon`.split("\n")
  gem.authors = ["Tim Peters"]

  gem.add_dependency 'nokogiri', '~> 1.6.7'
  gem.add_dependency 'httparty', '~> 0.13.7'
end