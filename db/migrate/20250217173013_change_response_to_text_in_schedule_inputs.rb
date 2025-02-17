class ChangeResponseToTextInScheduleInputs < ActiveRecord::Migration[7.2]
  def change
    change_column :schedule_inputs, :response, :text
  end
end
