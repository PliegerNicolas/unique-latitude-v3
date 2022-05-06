class MediumPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end

  # No one can show
  def index?
    false
  end

  # No one can show
  def show?
    false
  end

  # Staff member can new/create
  def create?
    user&.staff?
  end

  # Staff member can new/create
  def new?
    create?
  end

  # Staff member can edit/update
  def update?
    user&.staff?
  end

  def edit?
    update?
  end

  # Staff member can destroy
  def destroy?
    user&.staff?
  end
end
