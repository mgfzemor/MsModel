class CreatePrimaryKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :primary_keys do |t|
      t.references :table, foreign_key: true
      t.references :column, foreign_key: true

      t.timestamps
    end
  end
end
