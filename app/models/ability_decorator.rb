class AbilityDecorator
  include CanCan::Ability

  def initialize(user)
    can :read, Spree::Tracking do |tracking|
      tracking.order && tracking.order.user == user
    end
  end
end

Spree::Ability.register_ability(AbilityDecorator)
