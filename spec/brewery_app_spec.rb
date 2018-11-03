require File.expand_path 'spec_helper.rb', __dir__

RSpec.describe BreweryApp do
  subject { described_class.new }
  let(:delivery_simulator) { instance_double(DeliverySimulator) }
  let(:truck) { subject.helpers.truck }

  before do
    allow(DeliverySimulator).to receive(:new) { delivery_simulator }
    allow(delivery_simulator).to receive(:perform!)
  end

  it 'loads a truck' do
    expect(truck).to be_a(Truck)
  end

  describe 'GET /' do
    it 'allows accessing the home page' do
      get '/'

      expect(last_response).to be_ok
      expect(last_response.content_type).to eq('text/html;charset=utf-8')
    end
  end

  describe 'GET /truck.json' do
    it 'allows retrieving truck information as json' do
      get '/truck.json'

      expect(last_response).to be_ok
      expect(last_response.content_type).to eq('application/json')
      expect(last_response.body).to eq(truck.to_json)
    end
  end
end
