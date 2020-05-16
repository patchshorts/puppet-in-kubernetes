# PuppetInKubernetes::Gem

This gem represents shared code that can be used in various sub-component projects like `puppetserver`, `puppetdb`, `r10k`, etc. Since much of the testing functionality is quite similar across these components, there are a number of testing helpers here that these suites consume.

To experiment with the code here, run `bin/console` for an interactive prompt.

## Installation

For now, this gem is intended to be consumed by GitHub repo like

```ruby
gem 'PuppetInKubernetes',
  :git => 'https://github.com/patchshorts/puppet-in-kubernetes.git',
  :ref => 'master',
  :glob => 'gem/*.gemspec'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install PuppetInKubernetes

## Usage

These are internal spec helpers - see files in the spec directory for examples

## Development

You can run `bin/console` for an interactive prompt that will allow you to experiment.

While this gem is not currently being released to Rubygems, the rake tasks are included to enable that scenario should the need arise. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/patchshorts/puppet-in-kubernetes
