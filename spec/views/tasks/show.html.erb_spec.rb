require 'spec_helper'

describe "tasks/show.html.erb" do
  before(:each) do
    @task = assign(:task, stub_model(Task, 
      :start => Timeliness.parse('3/6/2011 7:45:59'), 
      :stop  => Timeliness.parse('3/6/2011 13:45')
    ))
  end

  it "shows start in a nice format" do
    render
    rendered.should include('3/6/2011 07:45:59')
  end

  it "shows stop in a nice format" do
    render
    rendered.should include('3/6/2011 13:45:00')
  end
  
  it "shows start time as a microformat hCalendar" do
    render
    assert_select '.vevent .dtstart', '3/6/2011 07:45:59'
  end

  it "has start time as a microformat hCalendar iso8601 datetime" do
    render
    assert_select '.vevent .dtstart .value-title' do |elements|
      elements.each do |element|
        element['title'].should include('2011-03-06T07:45:59-06:00')
      end
    end
  end
  
end
