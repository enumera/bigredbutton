class Task < ActiveRecord::Base
  attr_accessible :description, :time_record_ids, :note_ids

  has_many :time_records
  has_many :notes





end
