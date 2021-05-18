require 'spec_helper'
require './app/services/map_quest_service'
require './app/facades/distance_facade'

RSpec.describe DistanceFacade do
  it '.forecast' do
    VCR.use_cassette('no_to_chicago') do
      trip_params = {
        origin: 'New Orleans, LA',
        destination: 'Chicago, IL'
      }
      distance = DistanceFacade.calculate(trip_params)
      expect(distance).to have_key(:route)
      check_hash_structure(distance[:route], :distance, Numeric)
    end
  end
end
