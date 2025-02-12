class CreateEventTimes < ActiveRecord::Migration[7.2]
  def change
    create_table :event_times do |t|
      t.references :event, null: false, foreign_key: true
      t.datetime :start_time

      t.timestamps
    end
  end
end
