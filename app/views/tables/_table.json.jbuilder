json.extract! table, :id, :system_name, :database_name, :has_one, :belongs_to, :created_at, :updated_at
json.url table_url(table, format: :json)
