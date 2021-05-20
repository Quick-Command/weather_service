require 'bundler'
Bundler.require
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

$LOAD_PATH.unshift(File.expand_path("app", __dir__))

require './app/controllers/weather_service_app'

run WeatherServiceApp
