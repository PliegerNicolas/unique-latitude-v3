class ProjectPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user&.staff?
        scope.all
      else
        scope.where(published: true)        
      end
    end

    private

    attr_reader :user, :scope
  end

  # Everyone can index
  def index?
    true
  end

  # Everyone can show
  def show?
    true
  end

  # Staff member can new/create
  def create?
    user&.staff?
  end

  # Staff member can edit/update
  def update?
    user&.staff?
  end

  # Staff member can destroy
  def destroy?
    user&.staff?
  end
end
