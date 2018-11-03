require 'simplecov'
require 'simplecov-console'

SimpleCov.formatter =
  SimpleCov::Formatter::MultiFormatter.new([
                                             SimpleCov::Formatter::HTMLFormatter,
                                             SimpleCov::Formatter::Console
                                           ])
SimpleCov.start

require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../brewery_app.rb', __dir__

module RSpecMixin
  include Rack::Test::Methods
  def app
    described_class
  end
end

RSpec.configure { |c| c.include RSpecMixin }
