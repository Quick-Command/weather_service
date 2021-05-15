class HourlyWeather
  attr_reader :time,
              :temperature,
              :humidity,
              :wind_speed,
              :wind_deg,
              :wind_gust,
              :conditions,
              :precipitation

  def initialize(data)
    @time = Time.at(data[:dt]).strftime("%H:%M:%S")
    @temperature = data[:temp]
    @humidity = data[:humidity]
    @wind_speed = data[:wind_speed]
    @wind_deg = data[:wind_deg]
    @wind_gust = data[:wind_gust]
    @conditions = data[:weather].first[:description]
    @precipitation = data[:pop]
  end
end
