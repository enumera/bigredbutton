class Task < ActiveRecord::Base
  attr_accessible :name, :time_record_ids, :note_ids, :hours, :minutes
  belongs_to :group
  has_many :time_records
  has_many :notes





end
