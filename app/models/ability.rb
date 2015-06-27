class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user
    can :read, Event
    if user.admin?
      can :manage, :all
    elsif user.organizer?
      can :read, Event, Ticket
      can :create, Event, Ticket
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
