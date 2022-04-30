class Medium < ApplicationRecord
  has_one_attached :visual
  belongs_to :project
end
