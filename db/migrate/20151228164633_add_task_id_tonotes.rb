class AddTaskIdTonotes < ActiveRecord::Migration
	 def change
    add_column :notes, :task_id, :integer
  end
end
