require 'spec_helper'
require './app/poros/current_weather'
require './app/services/map_quest_service'
require './app/services/weather_service'


RSpec.describe CurrentWeather do
  describe 'happy path' do
    it 'should build a Current Weather PORO based on input' do
      VCR.use_cassette('get_current_weather_data') do
        location = 'jacksonville,fl'
        coordinates = MapQuestService.call(location)[:results].first[:locations].first[:latLng]
        forecast = WeatherService.find_forecast_for_location(coordinates[:lat], coordinates[:lng])
        current_weather = CurrentWeather.new(forecast[:current])

        expect(current_weather).to be_a(CurrentWeather)
        expect(current_weather.datetime).to be_a(String)
        expect(current_weather.datetime).to eq(Time.at(forecast[:current][:dt]).to_s)
        expect(current_weather.sunrise).to be_a(String)
        expect(current_weather.sunrise).to eq(Time.at(forecast[:current][:sunrise]).to_s)
        expect(current_weather.sunset).to be_a(String)
        expect(current_weather.sunset).to eq(Time.at(forecast[:current][:sunset]).to_s)
        expect(current_weather.temperature).to be_a(Numeric)
        expect(current_weather.humidity).to be_a(Numeric)
        expect(current_weather.conditions).to be_a(String)
      end
    end
  end
end
