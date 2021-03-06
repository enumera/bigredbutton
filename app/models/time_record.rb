class TimeRecord < ActiveRecord::Base
  attr_accessible :hours, :minutes, :state, :task_id

  belongs_to :task

  def calculate_time(record)
    time = []
    time_milli = record.updated_at - record.created_at

    record.hours = (time_milli/(60*60)).to_i
    record.minutes = ((time_milli - hours.round * (60*60))/(60)).to_i
    record.save

  end
end
