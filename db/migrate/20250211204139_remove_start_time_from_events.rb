class RemoveStartTimeFromEvents < ActiveRecord::Migration[7.2]
  def change
    remove_column :events, :start_time, :datetime
  end
end
