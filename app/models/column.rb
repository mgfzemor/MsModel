class Column < ApplicationRecord
  belongs_to :ms_column_types, foreign_key: "ms_column_types_id", class_name: "MsColumnType"
  belongs_to :tables, foreign_key: "tables_id", class_name: "Table"

  def ms_type
    self.ms_column_types.name
  end

  def ms_database_name
    self.ms_column_types.prefix + self.database_name
  end
end
