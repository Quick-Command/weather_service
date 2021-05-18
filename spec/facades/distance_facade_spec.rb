require 'spec_helper'
require './app/services/map_quest_service'
require './app/facades/distance_facade'

RSpec.describe DistanceFacade do
  xit '.forecast' do
    VCR.use_cassette('jacksonville,fl') do
      distance = DistanceFacade.forecast('jacksonville,fl')
      expect(distance).to have_key(:lat)
      expect(distance).to have_key(:lng)
    end
  end
end
