class AddGameTitleAndDataCenterToEvents < ActiveRecord::Migration[7.2]
  def change
    add_reference :events, :game_title, null: false, foreign_key: { to_table: :games }
    add_reference :events, :data_center, null: false, foreign_key: true
  end
end
