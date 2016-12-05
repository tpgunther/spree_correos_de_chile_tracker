class Spree::Tracking < ActiveRecord::Base
  belongs_to :order

  def self.request_delivery_state
    Spree::Order.where(state: 'complete').each(&:set_delivery_state)
  end

  def complete?
    return false if state.nil? or state.blank?
    last_delivery_state == 'ENVIO ENTREGADO'
  end

  def last_delivery_state
    return JSON.parse(state)['movements'][0]['status']
  end
end
