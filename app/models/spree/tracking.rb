class Spree::Tracking < ActiveRecord::Base
  belongs_to :order
end
