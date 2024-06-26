class Project < ApplicationRecord
  # Relationships
  
  has_many :media, dependent: :destroy
  belongs_to :user

  # Friendly Id sluggable

  extend FriendlyId
  friendly_id :title, use: :slugged

  # Validations 

  validates :title, :category, :status, :user_id, presence: true
  validates :title, :slug, uniqueness: true

  # Enums

  enum category: [:documentary, :institutional, :event]
  enum status: [:unpublished, :published]

  # Scopes

  scope :filter_by_status, ->(status) { where(status: status) }
  scope :filter_by_title, ->(title) { where("title ILIKE ?", "%#{title}%") }
  scope :filter_by_category, ->(category) { where(category: category) }

  # Actions

  # Turbo_stream

  after_update_commit do
    broadcast_update_to self, partial: "projects/partials/project", locals: { project: self }
    broadcast_remove_to self if self.status === "unpublished"
  end

  after_destroy_commit do
    broadcast_remove_to self
  end

  # Custom entity Methods

  def change_status!
    if self.status == "unpublished"
      self.status = "published"
    else
      self.status = "unpublished"
    end
  end

  private

  def should_generate_new_friendly_id?
    title_changed?
  end
end
