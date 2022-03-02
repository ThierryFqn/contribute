class ParticipationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def accepted?
    true
  end

  def denied?
    true
  end

  def cancelled?
    true
  end
end
