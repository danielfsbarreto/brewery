require 'active_support/core_ext/string'

class BeerContainer
  attr_accessor :current_temperature

  def initialize
    @current_temperature = 0
  end

  def to_json(*options)
    as_json.to_json
  end

  private

  attr_reader :ideal_temperature_range

  def as_json
    {
      kind: kind,
      min_temp: ideal_temperature_range.min,
      max_temp: ideal_temperature_range.max,
      current_temp: current_temperature,
      ideal: ideal_temperature?
    }
  end

  def kind
    self.class.name.gsub('Container', '').underscore.humanize
  end

  def ideal_temperature?
    ideal_temperature_range.cover?(current_temperature)
  end
end

class PilsnerContainer < BeerContainer
  def initialize
    @ideal_temperature_range = (-4..6)
    super
  end
end

class IPAContainer < BeerContainer
  def initialize
    @ideal_temperature_range = (-5..6)
    super
  end

  def kind
    'IPA'
  end
end

class LagerContainer < BeerContainer
  def initialize
    @ideal_temperature_range = (-4..7)
    super
  end
end

class StoutContainer < BeerContainer
  def initialize
    @ideal_temperature_range = (-6..8)
    super
  end
end

class WheatBeerContainer < BeerContainer
  def initialize
    @ideal_temperature_range = (-3..5)
    super
  end
end

class PaleAleContainer < BeerContainer
  def initialize
    @ideal_temperature_range = (-4..6)
    super
  end

  def kind
    'Pale Ale'
  end
end

class BeerContainer
  KINDS ||= [PilsnerContainer, IPAContainer, LagerContainer, StoutContainer, WheatBeerContainer, PaleAleContainer].freeze
end
