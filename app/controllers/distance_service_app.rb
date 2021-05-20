require './app/services/map_quest_service'
require './app/poros/distance_poro'
require './app/serializers/distance_serializer'
require './app/facades/distance_facade'
require 'sinatra'
require 'json'
require 'fast_jsonapi'
require 'sinatra/json'

class DistanceServiceApp < Sinatra::Base
  #get '/' do
  #   "Hello, World!"
  #end

  get '/api/v1/distance' do

      data = DistanceFacade.calculate(params)

      body DistanceSerializer.new(data).serialized_json
      status 200
  end

  #error 400..500 do
    #{}"Your distance could not be found"
  #end
end
