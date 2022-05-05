class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :nullify

  enum role: [:user, :moderator, :admin]
  
  scope :filter_by_username, ->(username) { where("username ILIKE ?", "%#{username}%") }

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def staff?
    self.role == "admin" || self.role == "moderator"
  end

  def promote
    role = self.role_before_type_cast
    role.between?(0,1) ? self.role = role + 1 : self.role = role
  end

  def promotion_permitted?(user)
    self.role_before_type_cast > user.role_before_type_cast
  end

  def demote
    role = self.role_before_type_cast
    role.between?(1,2) ? self.role = role - 1 : self.role = role
  end

  def demotion_permitted?(user)
    self.role_before_type_cast >= user.role_before_type_cast
  end
end
