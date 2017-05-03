class AbilityDecorator
  include CanCan::Ability

  def initialize(user)
    cannot :manage, Spree::Tracking
    can :index, Spree::Tracking
    can :read, Spree::Tracking do |tracking|
      tracking.order && tracking.order.user == user
    end
  end
end

Spree::Ability.register_ability(AbilityDecorator)
