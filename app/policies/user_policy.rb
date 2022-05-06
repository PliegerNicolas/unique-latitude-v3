class UserPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user&.staff?
        scope.all
      else
        scope.none       
      end
    end

    private

    attr_reader :user, :scope
  end

  # Moderator can index
  def index?
    user&.staff?
  end

  # Staff member if permitted can promote user
  def promote?
    user&.promotion_permitted?(record)
  end

  # Staff member if permitted can demote user
  def demote?
    user&.demotion_permitted?(record)
  end
end
