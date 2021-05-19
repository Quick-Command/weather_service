require 'json'
require 'faraday'
require 'fast_jsonapi'
require 'sinatra'
require './app/services/weather_service'
require './app/services/map_quest_service'
require './app/poros/forecast'
require 'sinatra/json'
require './app/facades/weather_facade'
require './app/serializers/forecast_serializer'

class WeatherServiceApp < Sinatra::Base
  before do
    content_type :json
  end

  set :root, File.expand_path("..", __dir__)

  get '/api/v1/forecast_data' do
    location = params[:location]
    weather = WeatherFacade.forecast(location)

    # render json: ForecastSerializer.new(weather)
    # status 201
    body ForecastSerializer.new(weather).serialized_json
    status 200
  end
end
