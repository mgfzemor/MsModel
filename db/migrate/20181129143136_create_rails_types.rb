class CreateRailsTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :rails_types do |t|
      t.string :name
      t.boolean :active_size

      t.timestamps
    end
  end
end
