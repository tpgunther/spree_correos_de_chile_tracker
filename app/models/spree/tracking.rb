class Spree::Tracking < ActiveRecord::Base
  belongs_to :order

  after_create :set_number

  validate :number, presence: true

  def self.request_delivery_state
    Spree::Order.where(state: 'complete').each(&:set_delivery_state)
  end

  def complete?
    return false if state.nil? or state.blank?
    last_delivery_state == 'ENVIO ENTREGADO'
  end

  def last_delivery_state
    JSON.parse(state)['movements'][0]['status']
  end

  def set_delivery_state
    update state: ::Parser::ParserHandler.get_track_info(number, :correos_de_chile_parser)
  end

  private

  # Custom for salco
  def set_number
    self.number = order.number.tr('R', '')
    save
  end
end
