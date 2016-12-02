module Spree
  Order.class_eval do
    # include Parser::CorreosDeChileParser

    has_one :tracking

    def delivery_state
      Parser::CorreosDeChileParser.getTrackInfo(tracking.number)
    end
  end
end
