class WeatherServiceApp < Sinatra::Base
  get '/' do
     "Hello, World!"
  end

  get '/api/v1/distance' do
    if params.empty?
      json ({:error => 'Please provide a origin and destination'})
    elsif params[:origin].nil?
      json ({:error => 'Please provide a origin'})
    elsif params[:destination].nil?
      json ({:error => 'Please provide a destination'})
    elsif params.count < 2 || params.count > 2
      json ({:error => 'Please provide only a origin and destination'})
    else
      data = DistanceFacade.calculate(params)
      body DistanceSerializer.new(data).serialized_json
      status 200
    end
  end

  error 400..500 do
    "Your distance could not be found"
  end
end
