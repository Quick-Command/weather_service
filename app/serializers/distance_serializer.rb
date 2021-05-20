require 'fast_jsonapi'
require './app/poros/distance_poro'
require './app/facades/distance_facade'

class DistanceSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attributes :origin, :destination, :distance_in_miles, :drive_time
end
