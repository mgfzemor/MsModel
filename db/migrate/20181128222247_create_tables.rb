class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :tables do |t|
      t.string :system_name
      t.string :database_name
      t.boolean :active_id
      t.boolean :active_created
      t.boolean :active_updated
      t.references(:projects)
      t.references(:table_types)
      t.timestamps
    end
  end
end
