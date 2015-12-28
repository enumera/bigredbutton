Feature: The ability to add and manage notes onto a task

@wips
Scenario: Add a note

	Given that I have selected a task and started a time record
	When I write a note and save the note
	Then the task has the note
