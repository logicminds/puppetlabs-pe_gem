source "https://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 3.7.0'
  gem "puppetlabs_spec_helper"

end

group :development do
  gem "travis"
  gem "travis-lint"
  gem "puppet-blacksmith"
  gem 'pry'
end

