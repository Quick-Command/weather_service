require 'spec_helper'
require './app/services/map_quest_service'
require './app/poros/distance_poro'

RSpec.describe DistancePoro do
  it 'exists and has attributes' do
    params = {
      origin: 'Denver,CO',
      destination: 'Seattle,WA'
    }
    travel_time = "18:24:27"

    distance_info = DistancePoro.new(params, travel_time)

    expect(distance_info).to be_a(DistancePoro)
    expect(distance_info).to have_attributes(
      start_city: params[:origin],
      end_city: params[:destination],
      travel_time: "18 hours, 24 minutes")
  end
end
