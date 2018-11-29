class AddPrefixToTableTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :table_types, :prefix, :string
  end
end
