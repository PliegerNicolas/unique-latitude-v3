class Medium < ApplicationRecord
  before_save :visual_conflit?

  # Relationships

  has_one_attached :visual, dependent: :destroy
  belongs_to :project

  # Validations
  
  validates :title, :priority_index, :project_id, presence: true # add visual here and check model 
  validates :title, uniqueness: { scope: :project_id }
  validates_numericality_of :priority_index, greater_than_or_equal_to: 1, less_than_or_equal_to: 100, message: '%{value} is not a valid value'
  validate :verify_url_validity

  # Enums
  
  # Scopes

  # Actions

  def visual_conflit?
    # Prioritize active storage
    if self.visual.attached?
      self.visual_url = nil
    end
  end

  def verify_url_validity
    
    self.visual_url.present? ? url = self.visual_url.to_str : return # Check if visual_url present

    youtube_regex = %r(^(http[s]*:\/\/)?(www.)?(youtube.com|youtu.be)\/(watch\?v=){0,1}([a-zA-Z0-9_-]{11}))
    vimeo_regex = %r(^https?:\/\/(?:.*?)\.?(vimeo)\.com\/(\d+).*$)

    youtube_matches = youtube_regex.match url
    vimeo_matches = vimeo_regex.match url

    if youtube_matches
      youtube_matches[6] || youtube_matches[5]
    elsif vimeo_matches
      vimeo_matches[2]
    else
      self.errors.add :base, "URL host must be youtube or vimeo and link must contain id."
    end
  end

  # Turbo_stream

  after_destroy_commit do
    broadcast_remove_to self
  end

  # Custom entity Methods
end