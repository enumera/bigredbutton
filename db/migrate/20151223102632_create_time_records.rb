class CreateTimeRecords < ActiveRecord::Migration
  def change
    create_table :time_records do |t|
      t.integer :task_id
      t.string :state
      t.integer :hours
      t.integer :minutes

      t.timestamps
    end
  end
end
