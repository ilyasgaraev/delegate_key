lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "delegate_key/version"

Gem::Specification.new do |spec|
  spec.name          = "delegate_key"
  spec.version       = DelegateKey::VERSION
  spec.authors       = ["Ilyas Garaev"]
  spec.email         = ["g.ilyas.ilm@gmail.com"]

  spec.summary       = "Provides a delegate_key class method"
  spec.description   = "Provides a delegate_key class method to easily create methods which return hash value by key"
  spec.homepage      = "https://github.com/ilyasgaraev/delegate_key"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^spec/}) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.0"

  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
end
