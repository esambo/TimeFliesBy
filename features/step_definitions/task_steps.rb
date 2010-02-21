Given /^I have a one minute old task$/ do
  @task = Task.create!(:title => 'first task', :start => 5.minutes.ago, :stop => 1.minute.ago, :user => current_user)
end

Given /^I have a task "([^\"]*)"$/ do |title|
  @task = Task.create!(:title => title, :start => 5.minutes.ago, :stop => 1.minute.ago, :user => current_user)
end

When /^I fill in all required fields$/ do
  fill_in(:start, :with => "12/28/2009 2:30 PM")
  fill_in(:stop,  :with => "12/28/2009 2:30 PM")
end

When /^it is "([^\"]*)"$/ do |datetime|
  Time.now = Time.parse(datetime)
end
