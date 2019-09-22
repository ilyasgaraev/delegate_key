# DelegateKey

Provides a `delegate_key` class method to easily create methods which return hash value by key.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'delegate_key'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install delegate_key

## Usage

### Options

- `:to` - specifies the target object;

- `:prefix` - prefixes the new method with the target name or a custom prefix;

- `:private` - if set to true, changes method visibility to private.

`delegate_key` method receives one or more method names (specified as symbols or strings) and the name of the target object via the `:to` option (also a symbol or string).

```ruby
class Foo
  delegate_key :key, to: :hash

  def hash
    { key: "value" }
  end
end

Foo.new.key # => "value"
```

If hash key is a string, use string as argument:

```ruby
class Foo
  delegate_key "key", to: :hash

  def hash
    { "key" => "value" }
  end
end

Foo.new.key # => "value"

class Foo
  delegate_key :key, to: :hash

  def hash
    { "key" => "value" }
  end
end

Foo.new.key # => nil
```

Multiple delegates to the same target are allowed:

```ruby
class Foo
  delegate_key :bar, :baz, to: :hash

  def hash
    { bar: "value for bar", baz: "value for baz" }
  end
end

Foo.new.bar # => "value for bar"
Foo.new.baz # => "value for baz"
```

Delegates can optionally be prefixed using the `:prefix` option. If the value is `true`, the delegate methods are prefixed with the name of the object being delegated to.

```ruby
class Foo
  delegate_key :key, to: :hash, prefix: true

  def hash
    { key: "value" }
  end
end

Foo.new.hash_key # => "value"
Foo.new.key # => NoMethodError: undefined method `key' for #<Foo:0x00007fc2452354b0>
```

It is also possible to supply a custom prefix:

```ruby
class Foo
  delegate_key :key, to: :hash, prefix: :custom

  def hash
    { key: "value" }
  end
end

Foo.new.custom_key # => "value"
```

The delegated methods are public by default. Pass `private: true` to change that.

```ruby
class Foo
  delegate_key :key, to: :hash, private: true

  def hash
    { key: "value" }
  end
end

Foo.new.key # => NoMethodError: private method `key' called for #<Foo:0x00007fc24531dd28>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/delegate_key. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DelegateKey project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/delegate_key/blob/master/CODE_OF_CONDUCT.md).
