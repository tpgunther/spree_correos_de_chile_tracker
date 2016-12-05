module Spree
  Order.class_eval do
    has_one :tracking

    after_create :generate_tracking

    def set_tracking_number(number)
      generate_tracking if tracking.nil?
      tracking.update number: number
      set_delivery_state
    end

    def last_delivery_state
      generate_tracking if tracking.nil?
      set_delivery_state if tracking.state.nil? or tracking.state.blank?
      tracking.last_delivery_state
    end

    # Call from worker
    def set_delivery_state
      generate_tracking if tracking.nil?
      return if tracking.complete?
      tracking.update state: ::Parser::ParserHandler.get_track_info(tracking.number, :correos_de_chile_parser)
    end

    private

    def generate_tracking
      self.tracking = Spree::Tracking.new
      save
    end
  end
end