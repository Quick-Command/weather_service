require 'json'
require 'faraday'
require 'fast_jsonapi'
require 'sinatra'
require './app/services/weather_service'
require './app/services/map_quest_service'
require 'sinatra/json'
require './app/facades/weather_facade'

class Forecast
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(data)
    @id = id
    @current_weather = CurrentWeather.new(data[:current])
    @daily_weather = five_day_daily_weather(data[:daily])
    @hourly_weather = eight_hour_weather(data[:hourly])
  end

  def five_day_daily_weather(data)
    find_first_five_days = data.first(5)
    find_first_five_days.map do |day|
      DailyWeather.new(day)
    end
  end

  def eight_hour_weather(data)
    find_eight_hour_weather = data.first(8)
    find_eight_hour_weather.map do |hour|
      HourlyWeather.new(hour)
    end
  end
end
