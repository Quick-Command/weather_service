require 'spec_helper'
require './app/services/map_quest_service'
require './app/poros/distance_poro'

RSpec.describe DistancePoro do
  it 'exists and has attributes' do
    params = {
      origin: 'Denver,CO',
      destination: 'Seattle,WA'
    }

    data = {
      route:
        {
        formattedTime: "18:24:27",
        distance: 1300
        }
    }

    distance_info = DistancePoro.new(params, data)

    expect(distance_info).to be_a(DistancePoro)
    expect(distance_info).to have_attributes(
      origin: params[:origin],
      destination: params[:destination],
      drive_time: "18 hours, 24 minutes away.",
      distance_in_miles: 1300)
  end

  it 'exists and does not have time attribute' do
    params = {
      origin: 'Denver,CO',
      destination: 'Seattle,WA'
    }

    data = {
      route:
        {
        distance: 1300
        }

    }

    distance_info = DistancePoro.new(params, data)

    expect(distance_info).to be_a(DistancePoro)
    expect(distance_info).to have_attributes(
      origin: params[:origin],
      destination: params[:destination],
      drive_time: "Can't reach incident.",
      distance_in_miles: 1300)
  end
end
