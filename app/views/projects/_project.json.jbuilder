json.extract! project, :id, :title, :slug, :subject, :category, :description, :location, :date, :user_id, :created_at, :updated_at
json.url project_url(project, format: :json)
