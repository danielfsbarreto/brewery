require File.expand_path '../../spec_helper.rb', __FILE__

RSpec.describe Truck do
  subject { described_class.new }

  it 'holds beer containers' do
    expect(subject.containers).to all (be_a(BeerContainer))
  end

  describe '#to_json' do
    class BeerContainerKindStub
      def to_json(*options)
        as_json.to_json
      end

      private def as_json
        {foo: 'bar'}
      end
    end

    before { stub_const('BeerContainer::KINDS', [BeerContainerKindStub]) }

    let(:truck_json) do
      {
        containers: [
          {foo: 'bar'}
        ]
      }.to_json
    end

    it 'returns beer containers as json' do
      expect(subject.to_json).to eq(truck_json)
    end
  end
end
