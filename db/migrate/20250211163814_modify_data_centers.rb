class ModifyDataCenters < ActiveRecord::Migration[7.2]
  def change
    # 不要なカラム(game_title_id)を削除
    remove_column :data_centers, :game_title_id

    # 新しいカラム(game_id)を追加
    add_column :data_centers, :game_id, :bigint, null: false

    # 外部キー制約を追加
    add_foreign_key :data_centers, :games, column: :game_id
  end
end
