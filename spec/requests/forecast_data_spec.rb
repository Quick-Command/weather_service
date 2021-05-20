require './app/services/weather_service'
require 'rspec'
require 'rack/test'
require 'spec_helper'
require './app/controllers/weather_service_app'
require './app/facades/weather_facade'
require './app/poros/forecast'

RSpec.describe 'Weather Service API App' do
  include Rack::Test::Methods
  describe 'happy path' do
    it 'has a successful response' do
      VCR.use_cassette('forecast_data') do
        location = 'denver,co'
        get "/api/v1/forecast_data?location=#{location}"

        expect(last_response).to be_ok

        result = JSON.parse(last_response.body, symbolize_names: true)
        data = result[:data]

        expect(data).to be_a(Hash)
        expect(data.keys).to eq([:id, :type, :attributes])
        expect(data.keys.count).to eq(3)
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to be_a(String)
        expect(data[:type]).to eq('forecast')
        expect(data[:attributes]).to be_a(Hash)
        expect(data[:attributes][:daily_weather].first.keys).to be_a(Array)
        expect(data[:attributes][:daily_weather].first.keys).to eq([
                                              :date, :sunrise, :sunset,
                                              :min_temp, :max_temp, :humidity,
                                              :wind_speed, :wind_deg, :wind_gust,
                                              :conditions, :precipitation
                                            ])
        expect(data[:attributes][:daily_weather].first.keys.count).to eq(11)
      end
    end
  end

  # describe 'sad path' do
  #   it 'returns errors for missing params' do
  #     get "/api/v1/forecast_data"
  #
  #     expect(last_response.status).to eq(400)
  #
  #     error = JSON.parse(last_response.body, symbolize_names: true)
  #
  #     expect(error).to be_a(Hash)
  #     expect(error).to be_a(String)
  #     expect(error).to eq('Parameter missing: Please provide a location')
  #   end
  # end
end
