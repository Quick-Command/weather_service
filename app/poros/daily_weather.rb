class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :min_temp,
              :max_temp,
              :humidity,
              :wind_speed,
              :wind_deg,
              :wind_gust,
              :conditions,
              :precipitation

  def initialize(data)
    @date = (Time.at(data[:dt])).strftime("%Y-%m-%d")
    @sunrise = Time.at(data[:sunrise]).to_s
    @sunset = Time.at(data[:sunset]).to_s
    @min_temp = data[:temp][:min]
    @max_temp = data[:temp][:max]
    @wind_speed = data[:wind_speed]
    @wind_deg = data[:wind_deg]
    @wind_gust = data[:wind_gust]
    @conditions = data[:weather].first[:description]
    @precipitation = data[:pop]
  end
end
