class Medium < ApplicationRecord
  has_one_attached :visual
  belongs_to :project

  validates :title, :priority_index, :project_id, presence: true
  validates_numericality_of :priority_index, greater_than_or_equal_to: 1, less_than_or_equal_to: 3, message: '%{value} is not a valid value'
end
