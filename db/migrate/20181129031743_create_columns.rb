class CreateColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :columns do |t|
      t.string :system_name
      t.string :database_name
      t.boolean :nn
      t.boolean :uq
      t.boolean :bin
      t.boolean :un
      t.boolean :zf
      t.boolean :g
      t.references :ms_column_types, foreign_key: true
      t.references :tables, foreign_key: true

      t.timestamps
    end
  end
end
