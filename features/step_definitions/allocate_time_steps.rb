Given(/^that I have three time records with a state of 'toallocate'$/) do
 @task = Task.create(description: "This task")
  @t1= TimeRecord.create(state: "toallocate", hours: 1, minutes: 45, task_id:@task.id)
  @t2= TimeRecord.create(state: "toallocate", hours: 1, minutes: 17, task_id:@task.id)
  @t3= TimeRecord.create(state: "toallocate", hours: 0, minutes: 45, task_id:@task.id)

end


When(/^when I request to view the tasks$/) do
  visit "/tasks"
  # pnding
end

Then(/^the time allocated to the task should be the (\d+) hours and (\d+) minutes$/) do |arg1, arg2|
  @task.reload.hours.should == 3
  @task.reload.minutes.should == 47

end

