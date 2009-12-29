Given /^I create a new task$/ do
  @task = Task.new
end

When /^I fill in all required fields$/ do
  fill_in(:start, :with => "12/28/2009 2:30 PM")
  fill_in(:stop,  :with => "12/28/2009 2:30 PM")
end

When /^I set "([^\"]*)" to "([^\"]*)"$/ do |field, value|
  @task = Task.new
  @task.send("#{field}=", value)
end

Then /^I should get a validation error$/ do
  @task.should_not be_valid
end
