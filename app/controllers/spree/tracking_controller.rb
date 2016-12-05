module Spree
  class TrackingController < Spree::StoreController

    def show
      @tracking = Tracking.find(params[:id])
    end
  end
end
