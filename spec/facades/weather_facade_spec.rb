require 'spec_helper'
require './app/services/map_quest_service'
require './app/facades/weather_facade'

RSpec.describe WeatherFacade do
  it '.forecast' do
    VCR.use_cassette('jacksonville,fl') do
      forecast = WeatherFacade.forecast('jacksonville,fl')
      expect(forecast).to be_a(Forecast)
      expect(forecast.daily_weather[0].conditions).to be_a(String)
      expect(forecast.daily_weather[0].date).to be_a(String)
      expect(forecast.daily_weather[0].humidity).to be_a(Numeric)
      expect(forecast.daily_weather[0].min_temp).to be_a(Numeric)
      expect(forecast.daily_weather[0].max_temp).to be_a(Numeric)
      expect(forecast.daily_weather[0].precipitation).to be_a(Numeric)
      expect(forecast.daily_weather[0].sunrise).to be_a(String)
      expect(forecast.daily_weather[0].sunset).to be_a(String)
    end
  end
end
