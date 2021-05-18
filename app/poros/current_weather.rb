class CurrentWeather
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :humidity,
              :conditions

  def initialize(data)
    @datetime = Time.at(data[:dt]).to_s
    @sunrise = Time.at(data[:sunrise]).to_s
    @sunset = Time.at(data[:sunset]).to_s
    @temperature = data[:temp]
    @humidity = data[:humidity]
    @conditions = data[:weather].first[:description]
  end
end
