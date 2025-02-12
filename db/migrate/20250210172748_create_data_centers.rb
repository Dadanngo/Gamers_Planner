class CreateDataCenters < ActiveRecord::Migration[7.2]
  def change
    create_table :data_centers do |t|
      t.string :name
      t.references :game_title, null: false, foreign_key: { to_table: :games }

      t.timestamps
    end
  end
end
