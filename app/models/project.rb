class Project < ApplicationRecord
  has_many :visual_media
  belongs_to :user

  validates_uniqueness_of :title, :slug

  enum category: [:documentary, :institutional, :event]

  before_create :slugify
  
  def slugify
      # This method is designed to make safe for URL usage the title of the project.
      self.slug = title.parameterize
  end
end
