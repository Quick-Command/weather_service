require './app/services/map_quest_service'
require 'rspec'
require 'rack/test'
require 'spec_helper'
require './app/controllers/weather_service_app'


describe 'Distance API' do
  include Rack::Test::Methods
  describe 'happy path' do
    it 'has a successful response' do
      VCR.use_cassette('denver_to_seattle') do
        params = {
          origin: 'Denver,CO',
          destination: 'Seattle,WA'
        }
        get "/api/v1/distance?origin=#{params[:origin]}&destination=#{params[:destination]}"

        expect(last_response).to be_ok

        parsed = JSON.parse(last_response.body, symbolize_names: true)
        data = parsed[:data]

        expect(data).to be_a(Hash)

      end
    end
  end

  describe 'sad path' do
    it 'returns errors for missing params' do
      params = {
        origin: 'Denver,CO',
        destination: 'Seattle,WA'
      }
      get "/api/v1/distance?origin=#{params[:origin]}"
      expect(last_response.status).to eq(401)
      error = JSON.parse(last_response.body, symbolize_names: true)

      expect(error).to be_a(String)
      expect(error).to eq('Parameter(s) missing: Please provide a valid origin and destination')
    end

    it 'returns errors for invalid location' do
      params = {
        origin: 'doifhdsfhdjsfl',
        destination: 'dlhflkdshfldsflsd'
      }
      get "/api/v1/distance?origin=#{params[:origin]}&destination=#{params[:destination]}"
      expect(last_response.status).to eq(401)
      error = JSON.parse(last_response.body, symbolize_names: true)

      expect(error).to be_a(String)
      expect(error).to eq('Parameter(s) missing: Please provide a valid origin and destination')
    end

    it 'returns errors for invalid params' do
      get "/api/v1/distance?nonsense=lfkjhdf"
      expect(last_response.status).to eq(401)
      error = JSON.parse(last_response.body, symbolize_names: true)

      expect(error).to be_a(String)
      expect(error).to eq('Parameter(s) missing: Please provide a valid origin and destination')
    end
  end
end
