require 'spec_helper'
require './app/poros/daily_weather'
require './app/services/map_quest_service'
require './app/services/weather_service'

RSpec.describe DailyWeather do
  describe 'happy path' do
    it 'should build an Daily Weather PORO based on input' do
      VCR.use_cassette('get_daily_weather_data') do
        location = 'jacksonville,fl'
        coordinates = MapQuestService.call(location)[:results].first[:locations].first[:latLng]
        forecast = WeatherService.get_forecast_for_location(coordinates[:lat], coordinates[:lng])
        daily_weather = DailyWeather.new(forecast[:daily].first)

        expect(daily_weather).to be_a(DailyWeather)
        expect(daily_weather.date).to be_a(String)
        expect(daily_weather.date).to eq(Time.at(forecast[:daily].first[:dt]).strftime("%Y-%m-%d"))
        expect(daily_weather.sunrise).to be_a(String)
        expect(daily_weather.sunrise).to eq(Time.at(forecast[:daily].first[:sunrise]).to_s)
        expect(daily_weather.sunset).to be_a(String)
        expect(daily_weather.sunset).to eq(Time.at(forecast[:daily].first[:sunset]).to_s)
        expect(daily_weather.min_temp).to be_a(Numeric)
        expect(daily_weather.max_temp).to be_a(Numeric)
        expect(daily_weather.humidity).to be_a(Numeric)
        expect(daily_weather.wind_speed).to be_a(Numeric)
        expect(daily_weather.wind_deg).to be_a(Numeric)
        expect(daily_weather.wind_gust).to be_a(Numeric)
        expect(daily_weather.conditions).to be_a(String)
        expect(daily_weather.precipitation).to be_a(Numeric)
      end
    end
  end
end
