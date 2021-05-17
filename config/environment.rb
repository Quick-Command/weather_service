require 'rubygems'
require "bundler"
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)
require "active_support/deprecation"
require "active_support/all"
require 'figaro/sinatra'
