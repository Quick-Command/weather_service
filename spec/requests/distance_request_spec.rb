require './app/services/map_quest_service'
require 'rspec'
require 'rack/test'
require 'spec_helper'
require './app/controllers/distance_service_app'


describe 'Climate Data API' do
  include Rack::Test::Methods

  def app
    @app = DistanceServiceApp
  end

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
