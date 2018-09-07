require 'rufus-scheduler'

class DeliverySimulator
  EVENT_POOL ||= %i[+ - noop].freeze
  private_constant :EVENT_POOL

  def initialize(subject)
    @subject = subject
  end

  def perform!
    Rufus::Scheduler.new.every '3s' do
      subject.containers.each do |c|
        event = EVENT_POOL.sample
        unless event == :noop
          new_value = c.current_temperature.public_send(event, 1)
          c.current_temperature = new_value
        end
      end
    end
  end

  private

  attr_reader :subject
end
