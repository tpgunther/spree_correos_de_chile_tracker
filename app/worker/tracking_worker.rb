class TrackingWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options retry: false

  recurrence { daily.hour_of_day(1).minute_of_hour(3) }

  def perform
    Spree::Tracking.request_delivery_state
  end
end
