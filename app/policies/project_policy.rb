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
        scope.where(status: "published")        
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

  def edit?
    update?
  end

  # Staff member can destroy
  def destroy?
    user&.staff?
  end

  # Staff member can change status
  def change_status?
    user&.staff?    
  end

  # Staff member can cancel edit
  def cancel?
    user&.staff?
  end
end
