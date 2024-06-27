class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.datetime :clock_in_at
      t.datetime :clock_out_at

      t.timestamps
    end
  end
end
