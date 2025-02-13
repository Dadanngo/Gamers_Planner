class CreateScheduleInputs < ActiveRecord::Migration[7.2]
  def change
    create_table :schedule_inputs do |t|
      t.references :event, null: false, foreign_key: true
      t.string :token, null: false
      t.string :job
      t.string :comment
      t.string :player_name

      t.timestamps
    end

    add_index :schedule_inputs, :token, unique: true
  end
end
