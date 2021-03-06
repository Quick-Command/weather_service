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
require './app/poros/distance_poro'
require './app/serializers/distance_serializer'
require './app/facades/distance_facade'

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

    rescue NoMethodError => e
      status 400
    end

    error 400 do
      body "Parameter missing: Please provide a valid location".to_json
    end


  get '/api/v1/distance' do
    begin
      data = DistanceFacade.calculate(params)
      if data.distance_in_miles == nil || data.drive_time == "Can't reach incident."
        body "Parameter(s) missing: Please provide a valid origin and destination".to_json
        status 401
      else
        body DistanceSerializer.new(data).serialized_json
        status 200
      end
    end

    rescue NoMethodError => e
    status 401

    end
    error 401 do
      body "Parameter(s) missing: Please provide a valid origin and destination".to_json
  end
end
