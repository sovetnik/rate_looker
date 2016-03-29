class RefreshWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  recurrence { minutely.second_of_minute(15, 45) }

  def perform
    RateRefreshJob.perform_later Exchange.first
  end
end
