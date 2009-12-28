Given /^I create a new task$/ do
  @task = Task.new
end

When /^I set "([^\"]*)" to "([^\"]*)"$/ do |field, value|
  @task = Task.new
  @task.title = value
  #@task.send(field, value)
end

Then /^I should get a validation error$/ do
  @task.valid?.should be_false
end