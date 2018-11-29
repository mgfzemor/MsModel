class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :tables do |t|
      t.string :system_name
      t.string :database_name
      t.references(:projects)
      t.references(:table_types)
      t.timestamps
    end
  end
end
