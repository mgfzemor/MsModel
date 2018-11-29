json.extract! table_type, :id, :name, :description, :created_at, :updated_at
json.url table_type_url(table_type, format: :json)
