Gem::Specification.new do |gem|
  gem.name = gem.summary = 'renault_address'
  gem.version = '1.0.0'
  gem.require_path = 'renault_address'
  gem.files = `git ls-files renault_address`.split("\n")
  gem.authors = ["Tim Peters"]

  gem.add_dependency 'httparty', '~> 0.14.0'
end
