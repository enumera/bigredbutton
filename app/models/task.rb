class Task < ActiveRecord::Base
  attr_accessible :description, :time_record_ids

  has_many :time_records





end
