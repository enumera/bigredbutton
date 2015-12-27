module SetupData


	def unallocated_task
		@default_task ||= Task.create(description: "unallocated")
	end

	def task_to_select
		@select_task ||= Task.create(description: "Task to select")
	end

end

World(SetupData)