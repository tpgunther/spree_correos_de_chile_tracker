module Spree
  class TrackingsController < Spree::StoreController
    authorize_resource

    def show
      @tracking = Tracking.find_by(number: params[:number])
      @tracking.order.last_delivery_state
      authorize! :read, @tracking
    end
  end
end
