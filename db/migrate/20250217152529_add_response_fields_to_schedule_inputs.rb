class AddResponseFieldsToScheduleInputs < ActiveRecord::Migration[7.2]
  def change
    add_column :schedule_inputs, :response, :string
    add_reference :schedule_inputs, :event_time, foreign_key: true
  end
end
