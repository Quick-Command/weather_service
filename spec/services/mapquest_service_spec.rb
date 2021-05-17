require 'spec_helper'
require './app/services/map_quest_service'
RSpec.describe MapQuestService do
  describe '.call' do
    it 'can get the coordinates of a city' do
      VCR.use_cassette('jacksonville') do
        city = 'jacksonville,fl'
        lat = 30.325968
        lng = -81.65676
        data = MapQuestService.call(city)
        expect(data).to be_a(Hash)
        check_hash_structure(data, :results, Array)
        expect(data[:results][0]).to be_a(Hash)
        check_hash_structure(data[:results][0], :locations, Array)
        location = data[:results][0][:locations][0]
        expect(location).to be_a(Hash)
        check_hash_structure(location, :latLng, Hash)
        check_hash_structure(location[:latLng], :lat, Float)
        expect(location[:latLng][:lat]).to eq(lat)
        check_hash_structure(location[:latLng], :lng, Float)
        expect(location[:latLng][:lng]).to eq(lng)
      end
    end

    it 'can get the coordinates of a different city' do
      VCR.use_cassette('chicago') do
        city = 'chicago, il'
        lat = 41.883229
        lng = -87.632398
        data = MapQuestService.call(city)
        expect(data[:results][0][:locations][0][:latLng][:lat]).to eq(lat)
        expect(data[:results][0][:locations][0][:latLng][:lng]).to eq(lng)
      end
    end
  end
<<<<<<< HEAD

  describe '.distance_call' do
    it 'gets info for a trip between two cities' do
      VCR.use_cassette('denver_to_seattle') do
        trip_params = {
          origin: 'Denver,CO',
          destination: 'Seattle,WA'
        }

        trip_info = MapQuestService.distance_call(trip_params)

        expect(trip_info).to be_a(Hash)
        check_hash_structure(trip_info, :route, Hash)
        check_hash_structure(trip_info[:route], :formattedTime, String)
        check_hash_structure(trip_info[:route], :time, Numeric)
        check_hash_structure(trip_info[:route], :distance, Numeric)
      end
    end

    it 'gets info for a trip between different cities' do
      VCR.use_cassette('no_to_chicago') do
        trip_params = {
          origin: 'New Orleans, LA',
          destination: 'Chicago, IL'
        }

        trip_info = MapQuestService.distance_call(trip_params)

        expect(trip_info).to be_a(Hash)
        check_hash_structure(trip_info, :route, Hash)
        check_hash_structure(trip_info[:route], :formattedTime, String)
        check_hash_structure(trip_info[:route], :time, Numeric)
        check_hash_structure(trip_info[:route], :distance, Numeric)
      end
    end
  end
=======
>>>>>>> 2c1977b7dcace3839a444b29bda6f0de53c8e5f3
end
