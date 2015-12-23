class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.integer	:hours
      t.integer :minutes

      t.timestamps
    end
  end
end
