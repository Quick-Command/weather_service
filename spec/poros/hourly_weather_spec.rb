require 'spec_helper'
require './app/poros/hourly_weather'
require './app/services/map_quest_service'
require './app/services/weather_service'


RSpec.describe HourlyWeather do
  describe 'happy path' do
    it 'should build an Hourly Weather PORO based on input' do
      VCR.use_cassette('get_hourly_weather_data') do
        location = 'jacksonville,fl'
        coordinates = MapQuestService.call(location)[:results].first[:locations].first[:latLng]
        forecast = WeatherService.get_forecast_for_location(coordinates[:lat], coordinates[:lng])
        hourly_weather = HourlyWeather.new(forecast[:hourly].first)

        expect(hourly_weather).to be_a(HourlyWeather)
        expect(hourly_weather.time).to be_a(String)
        expect(hourly_weather.time).to eq(Time.at(forecast[:hourly].first[:dt]).strftime("%H:%M:%S"))
        expect(hourly_weather.temperature).to be_a(Numeric)
        expect(hourly_weather.humidity).to be_a(Numeric)
        expect(hourly_weather.wind_speed).to be_a(Numeric)
        expect(hourly_weather.wind_deg).to be_a(Numeric)
        expect(hourly_weather.wind_gust).to be_a(Numeric)
        expect(hourly_weather.conditions).to be_a(String)
        expect(hourly_weather.precipitation).to be_a(Numeric)
      end
    end
  end
end
