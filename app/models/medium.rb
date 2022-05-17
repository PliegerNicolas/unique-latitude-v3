class Medium < ApplicationRecord
  include ActionView::RecordIdentifier # For dom_id

  # Relationships

  has_one_attached :visual, dependent: :destroy
  belongs_to :project

  # Validations
  
  validates :title, :priority_index, :project_id, presence: true # add visual here and check model 
  validates :title, uniqueness: { scope: :project_id }
  validates_numericality_of :priority_index, greater_than_or_equal_to: 1, less_than_or_equal_to: 3, message: '%{value} is not a valid value'

  # Enums
  
  # Scopes

  # Actions

  # Turbo_stream

  #after_create_commit do
  #  broadcast_append_to [project, :media], target: "#{dom_id(project)}_media"
  #  broadcast_update_to self
  #end

  #after_update_commit do
  #  broadcast_update_to self
  #end

  after_destroy_commit do
    broadcast_remove_to self
  end

  # Custom entity Methods
end