class Note < ActiveRecord::Base
  attr_accessible :content, :task_id
  belongs_to :task

end
