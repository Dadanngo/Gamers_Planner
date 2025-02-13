class RemoveNotNullConstraintFromDataCenterId < ActiveRecord::Migration[6.0]
  def change
    change_column_null :events, :data_center_id, true
  end
end
