class TrackingWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    Spree::Tracking.request_delivery_state
  end
end
