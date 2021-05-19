class DistancePoro
  attr_reader :origin,
              :destination,
              :drive_time,
              :distance_in_miles


  def initialize(params, data)
    @origin = params[:origin]
    @destination = params[:destination]
    @drive_time = travel_time(data)
    @distance_in_miles = data[:route][:distance]
  end

  def travel_time(data)
    return "Can't reach incident." if data[:route][:formattedTime].nil?
    time = data[:route][:formattedTime].split(':').map(&:to_i)
    "#{time[0]} #{'hour'.pluralize(time[0])}, #{time[1]} #{'minute'.pluralize(time[1])} away."
  end
end
