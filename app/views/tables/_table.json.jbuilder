json.extract! table, :id, :system_name, :database_name,:active_id, :active_created, :active_updated, :has_one, :belongs_to, :created_at, :updated_at
json.url table_url(table, format: :json)
