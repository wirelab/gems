Gem::Specification.new do |gem|
  gem.name = gem.summary = 'secure_link'
  gem.version = '1.0.0'
  gem.require_path = 'secure_link'
  gem.files = `git ls-files secure_link`.split("\n")
  gem.authors = ["Andre Kramer"]

  gem.add_dependency 'addressable', '~> 2.4.0'
end
