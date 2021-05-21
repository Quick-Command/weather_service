source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'
gem 'sinatra', require: 'sinatra/base'
gem 'pg'
gem 'sinatra-activerecord'
gem 'json'
gem 'shotgun'
gem 'faraday'
gem 'fast_jsonapi'
gem 'sinatra-contrib'
gem 'figaro', git: 'https://github.com/bpaquet/figaro.git', branch: 'sinatra'
gem 'travis'

group :development, :test do
  gem 'rspec'
  gem 'rspec-core'
  gem 'tux'
  gem 'capybara'
  gem 'launchy'
  gem 'rack-test'
  gem 'rake'
  gem 'pry'
  gem 'openssl'
end

group :test do
  gem 'simplecov'
  gem 'webmock'
  gem 'vcr'
end
