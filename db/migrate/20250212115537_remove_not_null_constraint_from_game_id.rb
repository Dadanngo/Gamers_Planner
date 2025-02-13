class RemoveNotNullConstraintFromGameId < ActiveRecord::Migration[6.0]
  def change
    change_column_null :events, :game_id, true
  end
end

