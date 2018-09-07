require_relative 'beer_container'

class Truck
  attr_reader :containers

  def initialize
    @containers = BeerContainer::KINDS.map { |container| container.new }
  end

  def to_json(*options)
    as_json.to_json
  end

  private

  def as_json
    {containers: containers}
  end
end
