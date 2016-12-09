module Spree
  Order.class_eval do
    has_one :tracking

    after_create :generate_tracking

    def last_delivery_state
      generate_tracking if tracking.nil?
      set_delivery_state if tracking.state.nil? or tracking.state.blank?
      tracking.last_delivery_state
    end

    def set_delivery_state
      generate_tracking if tracking.nil?
      return if tracking.complete?
      tracking.set_delivery_state
    end

    private

    def generate_tracking
      self.tracking = Spree::Tracking.new
    end
  end
end
