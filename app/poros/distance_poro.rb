class DistancePoro
  attr_reader :start_city,
              :end_city


  def initialize(params, travel_time = nil)
    @start_city = params[:origin]
    @end_city = params[:destination]
    @time = travel_time
  end

  def travel_time
    return 'impossible' if @time.nil?

    time = @time.split(':').map(&:to_i)
    "#{time[0]} #{'hour'.pluralize(time[0])}, #{time[1]} #{'minute'.pluralize(time[1])}"
  end
end
