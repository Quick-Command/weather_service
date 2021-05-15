require 'rails_helper'
RSpec.describe LocationService do
  describe '.call' do
    it 'can get the coordinates of a city' do
      VCR.use_cassette('jacksonville') do
        city = 'jacksonville,fl'
        lat = 30.325968
        lng = -81.65676
        data = LocationService.call(city)
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
        data = LocationService.call(city)
        expect(data[:results][0][:locations][0][:latLng][:lat]).to eq(lat)
        expect(data[:results][0][:locations][0][:latLng][:lng]).to eq(lng)
      end
    end
  end
end 
