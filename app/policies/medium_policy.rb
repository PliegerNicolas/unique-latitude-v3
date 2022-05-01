class MediumPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def resolve
      scope.all if user&.admin? || user&.moderator?
    end

    private

    attr_reader :user, :scope
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    user.admin? || user.moderator?
  end

  def edit?
    user.admin? || user.moderator?
  end

  def update?
    user.admin? || user.moderator?
  end

  def destroy?
    user.admin? || user.moderator?
  end
end
