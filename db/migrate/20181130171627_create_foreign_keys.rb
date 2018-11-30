class CreateForeignKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :foreign_keys do |t|
      t.integer :source_column, null: false
      t.integer :source_table, null: false
      t.integer :target_column, null: false
      t.integer :target_table, null: false
    end

    add_foreign_key :foreign_keys, :columns, column: :source_column
    add_foreign_key :foreign_keys, :columns, column: :target_column
    add_foreign_key :foreign_keys, :tables, column: :source_table
    add_foreign_key :foreign_keys, :tables, column: :target_table
  end
end
