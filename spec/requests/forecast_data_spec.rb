require './app/services/weather_service'
require 'rspec'
require 'rack/test'
require 'spec_helper'
require './app/controllers/weather_service_app'
require './app/facades/weather_facade'
require './app/poros/forecast'

RSpec.describe 'Weather Service API App' do
  include Rack::Test::Methods

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

#   it 'returns errors for missing params' do
#     get '/api/v1/climate_data'
#
#     expect(last_response).to be_ok
#
#     error = JSON.parse(last_response.body, symbolize_names: true)
#
#     expect(error).to be_a(Hash)
#     expect(error[:error]).to be_a(String)
#     expect(error[:error]).to eq('Please provide a region and vintage year')
#   end
#
#   it 'returns errors for missing region' do
#     get '/api/v1/climate_data?vintage=2017'
#
#     expect(last_response).to be_ok
#
#     error = JSON.parse(last_response.body, symbolize_names: true)
#
#     expect(error).to be_a(Hash)
#     expect(error[:error]).to be_a(String)
#     expect(error[:error]).to eq('Please provide a region')
#   end
#
#   it 'returns errors for missing region' do
#     get '/api/v1/climate_data?region=napa'
#
#     expect(last_response).to be_ok
#
#     error = JSON.parse(last_response.body, symbolize_names: true)
#
#     expect(error).to be_a(Hash)
#     expect(error[:error]).to be_a(String)
#     expect(error[:error]).to eq('Please provide a vintage year')
#   end
#
#   it 'returns error when more than region and vintage params passed' do
#     get '/api/v1/climate_data?region=napa&vintage=2017&beep=borp'
#
#     expect(last_response).to be_ok
#
#     error = JSON.parse(last_response.body, symbolize_names: true)
#
#     expect(error).to be_a(Hash)
#     expect(error[:error]).to be_a(String)
#     expect(error[:error]).to eq('Please provide only a region and vintage year')
#   end
#
#   it 'returns error when vintage is before 1970' do
#     get '/api/v1/climate_data?region=napa&vintage=1969'
#
#     expect(last_response).to be_ok
#
#     error = JSON.parse(last_response.body, symbolize_names: true)
#
#     expect(error).to be_a(Hash)
#     expect(error[:error]).to be_a(String)
#     expect(error[:error]).to eq('Please provide a vintage year between 1970 and 2020')
#   end
#
#   it 'returns error when vintage is after 2020' do
#     get '/api/v1/climate_data?region=napa&vintage=2021'
#
#     expect(last_response).to be_ok
#
#     error = JSON.parse(last_response.body, symbolize_names: true)
#
#     expect(error).to be_a(Hash)
#     expect(error[:error]).to be_a(String)
#     expect(error[:error]).to eq('Please provide a vintage year between 1970 and 2020')
#   end
#
#   it "returns error when no results are found" do
#     VCR.use_cassette('no_data') do
#       get '/api/v1/climate_data?region=xxxx&vintage=2011'
#
#       error = JSON.parse(last_response.body, symbolize_names: true)
#
#       expect(error).to be_a(Hash)
#       expect(error[:data][:error]).to be_a(Array)
#       expect(error[:data][:error][0][:msg]).to be_a(String)
#     end
#   end
# end
