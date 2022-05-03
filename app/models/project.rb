class Project < ApplicationRecord
  has_many :media, dependent: :destroy
  belongs_to :user

  validates :title, :subject, :category, :published, :user_id, presence: true

  enum category: [:documentary, :institutional, :event]
  enum published: [:unpublished, :published]

  scope :filter_by_status, ->(status) { where(published: status) }
  scope :filter_by_title, ->(title) { where("title ILIKE ?", "%#{title}%") }
  scope :filter_by_category, ->(category) { where(category: category) }

  before_create :slugify

  def slugify
    # This method is designed to make safe for URL usage the title of the project.
    self.slug = title.parameterize
  end
end
