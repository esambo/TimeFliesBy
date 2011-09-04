Given /^I have a task "([^\"]*)"$/ do |title|
  @task = Task.create!(:title => title, :start => 5.minutes.ago, :stop => 1.minute.ago, :user => current_user)
end

Given /^I have some tasks$/ do
  @task = Task.create!(:title => 'Oldest task',      :start => 5.minutes.ago, :stop => 4.minute.ago, :user => current_user)
  @task = Task.create!(:title => 'Old task',         :start => 4.minutes.ago, :stop => 3.minute.ago, :user => current_user)
  @task = Task.create!(:title => 'Most recent task', :start => 3.minutes.ago, :stop => 2.minute.ago, :user => current_user)
end

Given /^I have a task "([^\"]*)" that started "([^\"]*)" ago$/ do |title, duration_in_natural_language|
  seconds = parse_human_duration(duration_in_natural_language).round
  start = seconds.seconds.ago
  @task = Task.create!(:title => title, :start => start, :user => current_user)
end

Given /^I have a "([^\"]*)" task$/ do |duration_in_natural_language|
  seconds = parse_human_duration(duration_in_natural_language).round
  duration = seconds.seconds.ago
  @task = Task.create!(:title => 'task title', :start => duration, :stop => Time.now, :user => current_user)
end

Given /^I have a task "([^\"]*)" that started "([^\"]*)" and stopped "([^\"]*)" ago$/ do |title, start_age_duration, stop_age_duration|
  start = parse_human_duration(start_age_duration).round.seconds.ago
  stop  = parse_human_duration(stop_age_duration).round.seconds.ago
  @task = Task.create!(:title => title, 
                       :start => start, 
                       :stop  => stop, 
                       :user  => current_user
  )
end

When /^I fill in all required fields$/ do
  fill_in "task_start", :with => editable_date_time(Time.zone.now)
end

When /^it is "([^\"]*)"$/ do |datetime|
  Time.now = parse_us_date_time datetime
end

When /^I reload the page$/ do
  # temporarily needed until JavaScript duration
  case Capybara::current_driver
    when :selenium
      visit page.driver.browser.current_url
    when :rack_test
      visit [ current_path, page.driver.browser.last_request.env['QUERY_STRING'] ].reject(&:blank?).join('?')
    when :culerity
      page.driver.browser.refresh
    else
      raise "\nUnsupported Capybara driver '#{Capybara::current_driver}', path: '#{Capybara::current_path}', url: '#{Capybara::current_url}', use rack::test or selenium/webdriver\n"
  end
end

Then /^I should see "([^"]*)" (\w+) in task (\d+)$/ do |value, key, task_number|
  key = key.sub('start', 'dtstart')
  key = key.sub('title', 'summary')
  # row = task_number.to_i + 2
  # row += 1 if row > 3 'sub headline
  # within(".vevent:nth-child(#{row}) .#{key}") do
  #   page.text.strip.should == value
  # end
  element = page.all(:css, ".vevent .#{key}")[task_number.to_i - 1]
  element.text.strip.should == value
end

When /^I press "([^"]*)" in task (\d+)$/ do |button, task_number|
  element = page.all(:css, ".vevent")[task_number.to_i - 1]
  element.click_button(button)
  # end
end

When /^I press "([^"]*)" in the (\w+) task$/ do |button, task_position|
  task_index = case task_position
    when "newest"
      0
    when "oldest"
      -1
    else
      task_position - 1
  end
  element = page.all(:css, ".vevent")[task_index]
  element.click_button(button)
end

Then /^I should see more recent tasks first$/ do
  starts = page.all(:css, '.dtstart').map { |e| Time.parse(e.text.strip) }
  starts.first.should > starts.last
end
