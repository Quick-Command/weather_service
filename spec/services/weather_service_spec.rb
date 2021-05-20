require './app/services/weather_service'
require 'rspec'
require 'rack/test'
require 'pry'
require 'spec_helper'

RSpec.describe 'the weather service' do
  include Rack::Test::Methods
  describe 'happy path' do
    describe 'fetch data' do
      it 'returns the forecast data for a given location based on longitude and latitude' do
        VCR.use_cassette('weather_data_chicago') do
          lat = 41.8832
          lng = -87.6324
          data = WeatherService.get_forecast_for_location(lat, lng)

          expect(data).to be_a(Hash)

          check_hash_structure(data, :current, Hash)
          check_hash_structure(data[:current], :dt, Numeric)
          check_hash_structure(data[:current], :sunrise, Numeric)
          check_hash_structure(data[:current], :sunset, Numeric)
          check_hash_structure(data[:current], :temp, Numeric)
          check_hash_structure(data[:current], :humidity, Numeric)
          check_hash_structure(data[:current], :weather, Array)
          expect(data[:current][:weather].first).to be_a(Hash)
          check_hash_structure(data[:current][:weather].first, :description, String)

          check_hash_structure(data, :hourly, Array)

          expect(data[:hourly].first).to be_a(Hash)
          check_hash_structure(data[:hourly].first, :dt, Numeric)
          check_hash_structure(data[:hourly].first, :temp, Numeric)
          check_hash_structure(data[:hourly].first, :wind_deg, Numeric)
          check_hash_structure(data[:hourly].first, :wind_speed, Numeric)
          check_hash_structure(data[:hourly].first, :wind_gust, Numeric)
          check_hash_structure(data[:hourly].first, :weather, Array)
          expect(data[:hourly].first[:weather].first).to be_a(Hash)
          check_hash_structure(data[:hourly].first[:weather].first, :description, String)
          check_hash_structure(data[:hourly].first, :pop, Numeric)

          check_hash_structure(data, :daily, Array)

          expect(data[:daily].first).to be_a(Hash)
          check_hash_structure(data[:daily].first, :dt, Numeric)
          check_hash_structure(data[:daily].first, :sunrise, Numeric)
          check_hash_structure(data[:daily].first, :sunset, Numeric)
          check_hash_structure(data[:daily].first, :temp, Hash)
          check_hash_structure(data[:daily].first[:temp], :min, Numeric)
          check_hash_structure(data[:daily].first[:temp], :max, Numeric)
          check_hash_structure(data[:daily].first, :humidity, Numeric)
          check_hash_structure(data[:daily].first, :wind_speed, Numeric)
          check_hash_structure(data[:daily].first, :wind_deg, Numeric)
          check_hash_structure(data[:daily].first, :wind_gust, Numeric)
          check_hash_structure(data[:daily].first, :weather, Array)
          expect(data[:daily].first[:weather].first).to be_a(Hash)
          check_hash_structure(data[:daily].first[:weather].first, :description, String)
          check_hash_structure(data[:daily].first, :pop, Numeric)
        end
      end
    end
  end
end
