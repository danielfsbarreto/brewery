require File.expand_path '../spec_helper.rb', __dir__

RSpec.describe Truck do
  subject { described_class.new }

  it 'holds beer containers' do
    expect(subject.containers).to all be_a(BeerContainer)
  end

  describe '#to_json' do
    let(:beer_class) { class_double('BeerContainer') }
    let(:beer_container) { instance_double('BeerContainer') }

    before do
      stub_const('BeerContainer::KINDS', [beer_class])
      allow(beer_class).to receive(:new).and_return(beer_container)
      allow(beer_container).to receive(:to_json).and_return(
        { foo: 'bar' }.to_json
      )
    end

    let(:truck_json) do
      {
        containers: [
          { foo: 'bar' }
        ]
      }.to_json
    end

    it 'returns beer containers as json' do
      expect(subject.to_json).to eq(truck_json)
    end
  end
end
