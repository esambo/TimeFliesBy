require 'chronic_duration'

Given /^I have a task "([^\"]*)"$/ do |title|
  @task = Task.create!(:title => title, :start => 5.minutes.ago, :stop => 1.minute.ago, :user => current_user)
end

Given /^I have some tasks$/ do
  @task = Task.create!(:title => 'Oldest task',      :start => 5.minutes.ago, :stop => 4.minute.ago, :user => current_user)
  @task = Task.create!(:title => 'Old task',         :start => 4.minutes.ago, :stop => 3.minute.ago, :user => current_user)
  @task = Task.create!(:title => 'Most recent task', :start => 3.minutes.ago, :stop => 2.minute.ago, :user => current_user)
end

Given /^I have a "([^\"]*)" task$/ do |duration_in_natural_language|
  seconds = ChronicDuration.parse(duration_in_natural_language).round
  duration = seconds.seconds.ago
  @task = Task.create!(:title => 'task title', :start => duration, :stop => Time.now, :user => current_user)
end

Given /^I have a stop "([^\"]*)" ago$/ do |duration_in_natural_language|
  seconds = ChronicDuration.parse(duration_in_natural_language).round
  stop  = seconds.seconds.ago
  start = (seconds + 1).seconds.ago
  @task = Task.create!(:title => 'task with stop', 
                       :start => start, 
                       :stop  => stop, 
                       :user  => current_user
  )
end

When /^I fill in all required fields$/ do
  fill_in "task_start", :with => I18n.l(Time.zone.now, :format => :nice)
end

When /^it is "([^\"]*)"$/ do |datetime|
  Time.now = Timeliness.parse datetime #parse m/d/yy in US format
end

When /^I reload the page$/ do
  # temporarily needed until JavaScript duration
  case Capybara::current_driver
    when :selenium
      visit page.driver.browser.current_url
    when :rack_test
      visit [ current_path, page.driver.last_request.env['QUERY_STRING'] ].reject(&:blank?).join('?')
    when :culerity
      page.driver.browser.refresh
    else
      raise "\nUnsupported Capybara driver '#{Capybara::current_driver}', path: '#{Capybara::current_path}', url: '#{Capybara::current_url}', use rack::test or selenium/webdriver\n"
  end
end

Then /^I should see "([^"]*)" duration in task (\d+)$/ do |duration, number|
  durations = page.all(:css, '.duration').map { |e| e.text.strip }
  durations[number.to_i - 1].should == duration
end

Then /^I should see more recent tasks first$/ do
  starts = page.all(:css, '.dtstart').map { |e| Timeliness.parse(e.text.strip) }
  starts.first.should > starts.last
end
