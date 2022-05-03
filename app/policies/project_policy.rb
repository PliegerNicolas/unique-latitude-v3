class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def resolve
      if user&.admin? || user&.moderator?
        scope.all
      else
        scope.where(published: true)        
      end
    end

    private

    attr_reader :user, :scope
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.staff?
  end

  def edit?
    user.staff?
  end

  def update?
    user.staff?
  end

  def destroy?
    user.staff?
  end

  def cancel?
    user.staff?
  end
end
