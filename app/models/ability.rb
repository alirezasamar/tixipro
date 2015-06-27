class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.admin?
      can :manage, :all
    elsif user.organizer?
      can :read, Event
      can :create, Event
      can :update, Event do |event|
        event.try(:user) == user
      end
      can :destroy, Event do |event|
        event.try(:user) == user
      end
    elsif user.regular?
      can :read, Event
    end
  end
end
