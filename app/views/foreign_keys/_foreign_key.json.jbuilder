json.extract! foreign_key, :id, :source_column, :source_table, :target_column, :target_table, :created_at, :updated_at
json.url foreign_key_url(foreign_key, format: :json)
