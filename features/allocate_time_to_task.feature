Feature: A task should be allocate time when it is worked on



Scenario: Allocate time to task
	Given that I have three time records with a state of 'toallocate'
	When when I request to view the tasks
	Then the time allocated to the task should be the 3 hours and 5 minutes
