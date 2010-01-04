Given /^I create a new task$/ do
  @task = Task.new
end

Given /^I have a one minute old task$/ do
  @task = Task.create!(:title => 'first task', :start => 5.minutes.ago, :stop => 1.minute.ago)
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

When /^it is "([^\"]*)"$/ do |datetime|
  Time.now = Time.parse(datetime)
end
