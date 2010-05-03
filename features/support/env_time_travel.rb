require 'time_travel'

After('@time_travel') do
  Time.now = nil
end
