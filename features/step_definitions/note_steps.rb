Given(/^that I have selected a task and started a time record$/) do
  visit "/"
  click_button "bigredbutton"

	fill_in "task_description", :with=> "New task"
	click_button "Create Task"
	@task = Task.last
	tr = TimeRecord.last
  tr.task.description.should == "New task"
end

When(/^I write a note and save the note$/) do
  tr = TimeRecord.last
  tr.state.should == "open"

    fill_in "note_content", :with => "This is my new note"
    click_button "Save note"

end

Then(/^the task has the note$/) do
  @task.notes.should inlcudes?(my_note)
end