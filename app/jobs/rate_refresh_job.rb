class RateRefreshJob < ApplicationJob
  queue_as :default

  def perform(exchange)
    ActionCable.server.broadcast 'rate', rate: exchange.rate
  end
end
