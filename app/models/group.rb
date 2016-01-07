class Group < ActiveRecord::Base
  attr_accessible :name, :task_ids
  has_many :tasks
end
