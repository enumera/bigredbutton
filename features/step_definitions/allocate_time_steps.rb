Given(/^that I have three time records with a state of 'toallocate'$/) do
 @task = Task.create(description: "This task")
  @t1= TimeRecord.create(state: "toallocate", hours: 1, minutes: 0, task_id:@task.id)
  @t2= TimeRecord.create(state: "toallocate", hours: 1, minutes: 0, task_id:@task.id)
  @t3= TimeRecord.create(state: "toallocate", hours: 1, minutes: 5, task_id:@task.id)

end


When(/^when I request to view the tasks$/) do
  visit "/tasks"
  # pnding
end

# Then(/^the time allocated to the task should be the (#{CAPTURE_VALUE}) hours and (CAPTURE_VALUE) minutes$/) do |hours, minutes|
#   @task.reload.hours.should == hours
#   @task.reload.minutes.should == minutes

# end

Then(/^the time allocated to the task should be the (\d+) hours and (\d+) minutes$/) do |hours, minutes|
	 @task.reload.hours.should == hours.to_i
   @task.reload.minutes.should == minutes.to_i
end



Given(/^that I want to perform a task$/) do
  visit "/"
end

When(/^I press the big red button$/) do
 	click_button "bigredbutton"
end

Then(/^I will create a new time record$/) do
   TimeRecord.all.count.should == 1
   @t = TimeRecord.first
   @t.task_id.should eq(nil)


end

Then(/^my time record will not have a task$/) do
    @t.task_id.should eq(nil)
end


Given(/^that I want to record time against a current task$/) do
	# pending
  	Task.create(description: "dummy task")
  	@task = Task.create(description: "Task to select")
end

When(/^I will select that task$/) do
  	visit "/"
  	click_button "bigredbutton"
  	select "Task to select", :from=> "Task"
end

Then(/^I will click the big red button$/) do
 	click_button "bigredbutton"
end

Then(/^my time record will have the task id$/) do
  	tr = TimeRecord.last
  	tr.task.description.should == "Task to select"
end

@wips
Given(/^that I have started some time without a task$/) do
	visit "/"
	click_button "bigredbutton"

end

When(/^I complete the form for a task$/) do
    fill_in "task_description", :with=> "New Task"
    click_button "Create Task"
    @task = Task.last
end

Then(/^the task id will be allocated to the time_record$/) do
  	@timerecord = TimeRecord.last
  	@timerecord.task_id.should == @task.id
  	@timerecord.task.description.should_not == "unallocated"
end


Given(/^that I have a time_record with the state of "(.*?)"$/) do |state|
  	  unallocated_task
  	  visit "/"
  	  click_button "bigredbutton"
  	  @time_record = TimeRecord.last
  	  @time_record.task.should eq(nil)
end

When(/^I finish the time record$/) do
  	click_button "bigredbutton"
  	@time_record.reload.state.should == "toallocate"


end

Then(/^if there is no task allocated to the time record then allocate if to the task "(.*?)"$/) do |arg1|
  	@time_record.reload.task.description.should =="unallocated"
end


Given(/^that I want to record some time$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I press the big red button and I have not created a task$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^my time will be allocated to the default task$/) do
  pending # express the regexp above with the code you wish you had
end





