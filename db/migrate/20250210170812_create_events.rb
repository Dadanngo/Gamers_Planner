class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_time
      t.string :hunter_id
      t.string :lobby_id
      t.string :url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
