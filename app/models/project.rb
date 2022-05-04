class Project < ApplicationRecord
  has_many :media, dependent: :destroy
  belongs_to :user

  # Friendly Id sluggable

  extend FriendlyId
  friendly_id :title, use: :slugged

  # Validations 

  validates :title, :category, :published, :user_id, presence: true
  validates :title, :slug, uniqueness: true

  # Enums

  enum category: [:documentary, :institutional, :event]
  enum published: [:unpublished, :published]

  # Scopes

  scope :filter_by_status, ->(status) { where(published: status) }
  scope :filter_by_title, ->(title) { where("title ILIKE ?", "%#{title}%") }
  scope :filter_by_category, ->(category) { where(category: category) }

  private

  def should_generate_new_friendly_id?
    title_changed?
  end  
end
