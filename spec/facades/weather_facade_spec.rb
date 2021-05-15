require 'spec_helper'

RSpec.describe WeatherFacade do
  it '.forecast' do
    VCR.use_cassette('jacksonville,fl') do
      forecast = WeatherFacade.forecast('jacksonville,fl')
    end
  end
end
