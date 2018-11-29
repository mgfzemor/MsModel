class CreateMsColumnTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :ms_column_types do |t|
      t.string :name
      t.text :description
      t.string :prefix
      t.timestamps
    end
  end
end
