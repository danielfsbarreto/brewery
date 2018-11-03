require 'sinatra/base'

require_relative 'models/truck'
require_relative 'lib/delivery_simulator'

class BreweryApp < Sinatra::Base
  set :port, ENV['PORT'] || 4567

  attr_reader :truck

  def initialize
    @truck = Truck.new
    DeliverySimulator.new(truck).perform!
    super
  end

  get '/' do
    send_file 'public/index.html'
  end

  get '/truck.json' do
    content_type :json
    truck.to_json
  end

  run! if app_file == $PROGRAM_NAME
end
