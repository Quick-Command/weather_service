require 'spec_helper'
require './app/services/map_quest_service'
require './app/facades/weather_facade'

RSpec.describe WeatherFacade do
  xit '.forecast' do
    VCR.use_cassette('jacksonville,fl') do
      forecast = WeatherFacade.forecast('jacksonville,fl')
      expect(forecast).to have_key(:lat)
      expect(forecast).to have_key(:lng)
    end
  end
end
