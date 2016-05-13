Gem::Specification.new do |gem|
  gem.name = gem.summary = 'monkey'
  gem.version = '1.0.1'
  gem.require_path = 'monkey'
  gem.files = `git ls-files monkey`.split("\n")
  gem.authors = ["Tim Peters", "Andre Kramer"]

  gem.add_dependency 'mandrill-api', '~> 1.0.53'
end
