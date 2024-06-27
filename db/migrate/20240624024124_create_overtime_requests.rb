class CreateOvertimeRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :overtime_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :department, null: false
      t.references :work_pattern, null: false, foreign_key: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.text :reason

      t.timestamps
    end
  end
end