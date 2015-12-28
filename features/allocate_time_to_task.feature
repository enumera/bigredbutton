Feature: A task should be allocate time when it is worked on



Scenario: When there have been no tasks created
	Given that I want to record some time
	When I press the big red button and I have not created a task
	Then my time will be allocated to the default task


Scenario:  Create a time record
	Given that I want to perform a task
	When I press the big red button
	Then I will create a new time record
	And my time record will not have a task


Scenario:  Create a new time record with a current task
	Given that I want to record time against a current task
	When I will select that task
	Then I will click the big red button
	And my time record will have the task id


Scenario: Allocate time to task
	Given that I have three time records with a state of 'toallocate'
	When when I request to view the tasks
	Then the time allocated to the task should be the 3 hours and 5 minutes


Scenario: Allocate time being recorded to a task
	Given that I have started some time without a task
	When I complete the form for a task
	Then the task id will be allocated to the time_record


Scenario: Allocate to task unallocated if no task is selected or created
	Given that I have a time_record with the state of "open"
	When I finish the time record
	Then if there is no task allocated to the time record then allocate if to the task "unallocated"

	
