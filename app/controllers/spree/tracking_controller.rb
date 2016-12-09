module Spree
  class TrackingController < Spree::StoreController
    authorize_resource

    def show
      @tracking = Tracking.find_by(number: params[:number])
      @tracking.order.last_delivery_state
    end
  end
end
