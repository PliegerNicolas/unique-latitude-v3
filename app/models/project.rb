class Project < ApplicationRecord
  has_many :visual_media
  belongs_to :user

  enum category: [:documentary, :institutional, :event]
  enum published: [:unpublished, :published]

  before_create :slugify

  def slugify
    # This method is designed to make safe for URL usage the title of the project.
    self.slug = title.parameterize
  end
end
