class MapQuestService
  def self.call(location)
    response = conn.get do |req|
      req.params[:location] = location
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.distance_call(params)
      response = distance_conn.get do |req|
        req.params[:from] = params[:origin]
        req.params[:to] = params[:destination]
      end
      JSON.parse(response.body, symbolize_names: true)
    end

  private

  def self.conn
    @conn ||= Faraday.new('https://mapquestapi.com/geocoding/v1/address') do |req|
      req.params[:key] = ENV['MAPQUEST_KEY']
    end
  end

  def self.distance_conn
    @distance_conn ||= Faraday.new('http://www.mapquestapi.com/directions/v2/route') do |req|
      req.params[:key] = ENV['MAPQUEST_KEY']
    end
  end
end
