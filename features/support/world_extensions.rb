module SetupData


	def unallocated_task
		@default_task ||= Task.create(name: "unallocated")
	end

	def task_to_select
		@select_task ||= Task.create(name: "Task to select")
	end

	def my_note
		@note ||= Note.new
	end

end

World(SetupData)