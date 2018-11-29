class AddRailsTypeToMsColumnType < ActiveRecord::Migration[5.2]
  def change
    add_reference :ms_column_types, :rails_types, foreign_key: true
  end
end
