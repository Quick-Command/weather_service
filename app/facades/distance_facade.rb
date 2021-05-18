class DistanceFacade
  def self.calculate(params)
    distance_data = MapQuestService.distance_call(params)
     DistancePoro.new(params, distance_data)
  end
end
