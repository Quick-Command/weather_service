class DistanceFacade
  def self.calculate(params)
    distance_data = MapQuestService.distance_call(params)
    DistancePoro.new(distance_data)
  end
end 
