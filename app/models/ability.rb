class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user
    can :read, Event
    if user.admin?
      can :manage, :all
    elsif user.curator?
      can :read, Event, Ticket
    elsif user.subcurator?
      can :read, Event, Ticket
    elsif user.regular?
      can :read, Event, Ticket
    end
  end
end
