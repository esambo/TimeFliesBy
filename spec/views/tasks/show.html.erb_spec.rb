require 'spec_helper'

describe "tasks/show.html.erb" do
  before(:each) do
    @task = assign(:task, stub_model(Task, 
      :start => Timeliness.parse('3/6/2011 7:45:59'), 
      :stop  => Timeliness.parse('3/6/2011 13:45')
    ))
  end

  describe "#start" do
    it "shows nice format" do
      render
      rendered.should include('3/6/2011 07:45:59')
    end

    it "is in a Microformats hCalendar" do
      render
      assert_select '.vevent .dtstart', '3/6/2011 07:45:59'
    end

    it "has a Microformats hCalendar iso8601 title" do
      render
      assert_select '.vevent .dtstart .value-title' do |elements|
        elements[0]['title'].should include('2011-03-06T07:45:59-06:00')
      end
    end
    
  end
  
  describe "#stop" do
    it "shows nice format" do
      render
      rendered.should include('3/6/2011 13:45:00')
    end
    
  end
  
  describe "#duration" do
    it "shows nice format" do
      render
      assert_select '.vevent .duration', '5h 59m 1s'
    end
  
    it "has a Microformats iso8601 title" do
      render
      assert_select '.vevent .duration .value-title' do |elements|
        elements[0]['title'].should include('PT5H59M1S')
      end
    end
    
  end
  
end
