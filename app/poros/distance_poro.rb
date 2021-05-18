class DistancePoro
  attr_reader :start_city,
              :end_city,
              :time,
              :distance


  def initialize(params, data)
    @start_city = params[:origin]
    @end_city = params[:destination]
    @time = travel_time(data)
    @distance = data[:route][0][:distance]
  end

  def travel_time(data)
    return "Can't reach incident." if data[:route][0][:formattedTime].nil?
    time = data[:route][0][:formattedTime].split(':').map(&:to_i)
    "#{time[0]} #{'hour'.pluralize(time[0])}, #{time[1]} #{'minute'.pluralize(time[1])} away."
  end
end
