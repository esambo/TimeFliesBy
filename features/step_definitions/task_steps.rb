require 'chronic_duration'

Given /^I have a one minute old task$/ do
  @task = Task.create!(:title => 'first task', :start => 5.minutes.ago, :stop => 1.minute.ago, :user => current_user)
end

Given /^I have a task "([^\"]*)"$/ do |title|
  @task = Task.create!(:title => title, :start => 5.minutes.ago, :stop => 1.minute.ago, :user => current_user)
end

Given /^I have a task with "([^\"]*)" duration$/ do |duration_in_natural_language|
  seconds = ChronicDuration.parse(duration_in_natural_language).round
  duration = seconds.seconds.ago
  @task = Task.create!(:title => 'task title', :start => duration, :stop => Time.now, :user => current_user)
end


When /^I fill in all required fields$/ do
  fill_in 'task_start', :with => I18n.l(Time.zone.now, :format => :nice)
  fill_in 'task_stop',  :with => I18n.l(Time.zone.now, :format => :nice)
end

When /^it is "([^\"]*)"$/ do |datetime|
  Time.now = Timeliness.parse datetime #parse m/d/yy in US format
end
