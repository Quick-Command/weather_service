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
  set :show_exceptions, false
  # disable :raise_errors

  get '/api/v1/forecast_data' do
    begin
      location = params[:location]
      weather = WeatherFacade.forecast(location)

      body ForecastSerializer.new(weather).serialized_json
      status 200

    end
    # rescue NoMethodError => e
    #   status 400
    # end

    # if params[:location].nil?
    #   halt 400, "Location paramter is missing."
    # end


    # error 400 do
    #   "Parameter missing: Please provide a location"
    # end

    # error 400..500 do
    #   "Location not found. Please enter valid location."
    # end
  end
end
