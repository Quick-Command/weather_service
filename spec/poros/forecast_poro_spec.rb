require 'spec_helper'
require './app/poros/forecast'
require './app/poros/current_weather'
require './app/poros/daily_weather'
require './app/poros/hourly_weather'
require './app/services/map_quest_service'
require './app/services/weather_service'

RSpec.describe Forecast do
describe 'happy path' do
  it 'should build a Forecast PORO that combines current, daily and hourly forecasts' do
    VCR.use_cassette('get_forecast_poro_data') do
      location = 'jacksonville,fl'
      coordinates = MapQuestService.call(location)[:results].first[:locations].first[:latLng]
      weather = WeatherService.get_forecast_for_location(coordinates[:lat], coordinates[:lng])
      forecast = Forecast.new(weather)

      expect(forecast).to be_a(Forecast)
      expect(forecast.current_weather).to be_a(CurrentWeather)
      expect(forecast.daily_weather.first).to be_a(DailyWeather)
      expect(forecast.hourly_weather.first).to be_a(HourlyWeather)
    end
  end
end
end
