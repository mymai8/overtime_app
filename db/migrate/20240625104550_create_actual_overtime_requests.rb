class CreateActualOvertimeRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :actual_overtime_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :actual_start_time, null: false
      t.datetime :actual_end_time, null: false
      t.integer :break_time, null: false
      t.string :overtime_report, null: false

      t.timestamps
    end
  end
end
