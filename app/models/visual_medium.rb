class VisualMedium < ApplicationRecord
  belongs_to :project

  validates_uniqueness_of :title, :url

  enum media: [:photo, :video]
end
