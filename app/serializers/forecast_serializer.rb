require 'fast_jsonapi'
require './app/poros/current_weather'
require './app/poros/daily_weather'
require './app/poros/hourly_weather'
require './app/poros/forecast'

class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :daily_weather
end
