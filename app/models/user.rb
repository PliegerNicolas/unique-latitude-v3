class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :nullify

  enum role: [:user, :moderator, :admin]
  
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def staff?
    self.role == "admin" || self.role == "moderator"
  end

  def promote
    role = self.role_before_type_cast
    role == 0 ? self.role = role + 1 : self.role = role
  end

  def demote
    role = self.role_before_type_cast
    role.between?(1,2) ? self.role = role - 1 : self.role = role
  end
end
