require 'spec_helper'

describe "tasks/show.html.erb" do
  before(:each) do
    @task = assign(:task, stub_model(Task, 
      :start => Timeliness.parse('3/6/2011 7:45:59'),
      :tags  => [
        stub_model(Tag, :name => 'Education'), 
        stub_model(Tag, :name => 'Read Book')
      ]
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
      @task[:stop] = Timeliness.parse('3/6/2011 13:45')
      render
      rendered.should include('3/6/2011 13:45:00')
    end
    
    it "shows nothing if blank" do
      render
      rendered.should_not include('3/6/2011 13:45:00')
    end

    it "is in a Microformats hCalendar" do
      @task[:stop] = Timeliness.parse('3/6/2011 13:45')
      render
      assert_select '.vevent .dtend', '3/6/2011 13:45:00'
    end
    
    it "has 'Active' in Microformats hCalendar value if stop is empty" do
      render
      assert_select '.vevent .dtend', 'Active'
    end

    it "has a Microformats hCalendar iso8601 title" do
      @task[:stop] = Timeliness.parse('3/6/2011 13:45')
      render
      assert_select '.vevent .dtend .value-title' do |elements|
        elements[0]['title'].should include('2011-03-06T13:45:00-06:00')
      end
    end
    
    it "has no Microformats hCalendar iso8601 title if stop is empty" do
      render
      assert_select '.vevent .dtend .value-title' do |elements|
        elements[0]['title'].should_not include('T')
      end
    end
  end
  
  describe "#duration" do
    it "shows nice format" do
      @task[:stop] = Timeliness.parse('3/6/2011 13:45')
      render
      assert_select '.vevent .duration', '5h 59m 1s'
    end
    
    it "shows 0s" do
      @task[:stop] = @task[:start]
      render
      assert_select '.vevent .duration', '0s'
    end
  
    it "has a Microformats iso8601 title" do
      @task[:stop] = Timeliness.parse('3/6/2011 13:45')
      render
      assert_select '.vevent .duration .value-title' do |elements|
        elements[0]['title'].should include('PT5H59M1S')
      end
    end
  end
  
  describe "#tags" do
    it "shows tags" do
      render
      assert_select '.vevent [rel="tag"]' do |elements|
        elements[0].children.join(', ').should include('Education')
        elements[1].children.join(', ').should include('Read Book')
      end
    end
  end
  
end
