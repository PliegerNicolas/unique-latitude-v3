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

  def promote?
    user&.staff?
  end

  def demote?
    user&.staff?
  end
end
