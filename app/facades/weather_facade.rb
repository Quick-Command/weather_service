require 'json'
require 'faraday'
require 'fast_jsonapi'
require 'sinatra'
require './app/services/weather_service'
require './app/services/map_quest_service'
require './app/poros/current_weather'
require './app/poros/daily_weather'
require './app/poros/hourly_weather'
require './app/poros/forecast'
require 'sinatra/json'

class WeatherFacade
  def self.forecast(location)
    location_data = MapQuestService.call(location)
    coordinates = lookup(location)
    weather_data = WeatherService.get_forecast_for_location(coordinates[:lat], coordinates[:lng])
    forecast = Forecast.new(weather_data)
  end

  def self.lookup(location)
   location_data = MapQuestService.call(location)
   coordinates = location_data[:results][0][:locations][0][:latLng]
   coordinates if coordinates != { lat: 39.390897, lng: -99.066067}
 end

end
