require 'spec_helper'

describe Task do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :start => Time.now,
      :stop => Time.now,
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    Task.create!(@valid_attributes)
  end

  it "should require start" do
    task = Task.new
    task.should_not be_valid
  end

  it "should not validate for stop before start" do
    task = Task.new
    task.start = Time.now
    task.stop = 5.minutes.ago
    task.should_not be_valid
  end

  context "with frozen time" do
    before :each do
      Time.now = "2010-01-03 9:13:23 AM" #freeze time using time_travel plugin
    end

    after :each do
      Time.now = nil #undo time_travel
    end

    it "should set start and stop to Time.now when using NOW on the first task" do
      task = Task.new
      task.now
      task.start.should == Time.now
      task.stop.should == Time.now
      task.no_stop_from_previous_on_now.should be_true
    end

    it "should set stop to Time.now when using NOW on new task" do
      task = Task.new
      task.now
      task.stop.should == Time.now
    end

    it "should set start to previous stop when using NOW on new task" do
      prev = Task.create! :start => 5.minutes.ago, :stop => 4.minutes.ago
      task = Task.new
      task.now
      task.start.should be < Time.now
      task.start.should == prev.stop
      task.no_stop_from_previous_on_now.should be_false
    end
  end

end
