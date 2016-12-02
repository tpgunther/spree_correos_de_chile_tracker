module Spree
  Order.class_eval do
    # include ::Parsers::CorreosDeChileParser

    has_one :tracking

    def delivery_state
      ::Parsers::CorreosDeChileParser.getTrackInfo(tracking.number)
    end
  end
end
