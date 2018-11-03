require File.expand_path '../../spec_helper.rb', __FILE__

RSpec.shared_examples 'BeerContainer' do |attributes|
  subject { described_class.new }

  it 'starts of with current_temperature as 0' do
    expect(subject.current_temperature).to eq(0)
  end

  describe '#to_json' do
    it 'returns json representation' do
      expect(JSON.parse(subject.to_json, symbolize_names: true)).to include(
        {
          kind: attributes[:kind],
          min_temp: attributes[:min_temp],
          max_temp: attributes[:max_temp],
          current_temp: 0
        }
      )
    end

    describe 'current_temp' do
      before { subject.current_temperature = 10 }

      it 'renders current_temp based on the current_temperature' do
        expect(JSON.parse(subject.to_json)).to include('current_temp' => 10)
      end
    end

    describe 'ideal' do
      describe 'for temperatures inside the ideal range' do
        let(:ideal) { true }

        context 'when set as the minimum' do
          before { subject.current_temperature = attributes[:min_temp] }

          it 'renders ideal as true' do
            expect(JSON.parse(subject.to_json)).to include('ideal' => ideal)
          end
        end

        context 'when set as the maximum' do
          before { subject.current_temperature = attributes[:max_temp] }

          it 'renders ideal as true' do
            expect(JSON.parse(subject.to_json)).to include('ideal' => ideal)
          end
        end
      end

      describe 'for temperatures outside the ideal range' do
        let(:ideal) { false }

        context 'when set as below the minimum' do
          before { subject.current_temperature = attributes[:min_temp] - 1 }

          it 'renders ideal as false' do
            expect(JSON.parse(subject.to_json)).to include('ideal' => ideal)
          end
        end

        context 'when set as above the maximum' do
          before { subject.current_temperature = attributes[:max_temp] + 1 }

          it 'renders ideal as false' do
            expect(JSON.parse(subject.to_json)).to include('ideal' => ideal)
          end
        end
      end
    end
  end
end

RSpec.describe PilsnerContainer do
  it_behaves_like 'BeerContainer', kind: 'Pilsner', min_temp: -4, max_temp: 6
end

RSpec.describe IPAContainer do
  it_behaves_like 'BeerContainer', kind: 'IPA', min_temp: -5, max_temp: 6
end

RSpec.describe LagerContainer do
  it_behaves_like 'BeerContainer', kind: 'Lager', min_temp: -4, max_temp: 7
end

RSpec.describe StoutContainer do
  it_behaves_like 'BeerContainer', kind: 'Stout', min_temp: -6, max_temp: 8
end

RSpec.describe WheatBeerContainer do
  it_behaves_like 'BeerContainer', kind: 'Wheat beer', min_temp: -3, max_temp: 5
end

RSpec.describe PaleAleContainer do
  it_behaves_like 'BeerContainer', kind: 'Pale Ale', min_temp: -4, max_temp: 6
end
