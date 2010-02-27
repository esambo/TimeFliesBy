require 'spec_helper'
include AuthenticationHelperMethods

describe Task do
  before(:each) do
    @valid_user = create_user(:email => 'valid_user@timefliesby.com')
    @valid_attributes = {
      :title => "valid title",
      :start => Time.now,
      :stop => Time.now,
      :description => "valid description"
    }
  end

  it "should only show tasks for the current user" do
    u1 = create_user(:email => 'models_test_user_3@timefliesby.com')
    Task.all.size.should == 0
    u1.tasks.create({:title => "Task 1 for user: 1", :start => 1.minutes.ago, :stop => Time.now})
    Task.all.size.should == 1

    u2 = create_user(:email => 'models_test_user_2@timefliesby.com')
    u2.tasks.all.size.should == 0
    u2.tasks.create({:title => "Task 1 for user: 2", :start => 1.minute.ago, :stop => Time.now})
    u2.tasks.all.size.should == 1
  end

  it "should create a new instance given valid attributes" do
    @valid_user.tasks.create!(@valid_attributes)
  end

  it "should require start" do
    task = @valid_user.tasks.new
    task.should_not be_valid
    task.errors[:start].should_not be_blank
  end

  it "should not validate for stop before start" do
    task = @valid_user.tasks.new
    task.start = Time.now
    task.stop = 5.minutes.ago
    task.should_not be_valid
    task.errors[:stop].should_not be_blank
  end

  it "should require user" do
    task = Task.new
    task.should_not be_valid
    task.errors[:user].should_not be_blank
  end

  it "should require valid user" do
    task = @valid_user.tasks.new
    task.start = 1.minutes.ago
    task.stop = Time.now
    task.user_id = 9999
    task.should_not be_valid
    task.errors[:user].should_not be_blank
  end

  it "should create a valid task" do
    task = @valid_user.tasks.new
    task.start = 1.minutes.ago
    task.stop = Time.now
    task.should be_valid
  end

  context "with frozen time" do
    before :each do
      Time.now = "2010-01-03 9:13:23 AM" #freeze time using time_travel plugin
    end

    after :each do
      Time.now = nil #undo time_travel
    end

    it "should set start and stop to Time.now when using NOW on the first task" do
      task = @valid_user.tasks.new
      task.now
      task.start.should == Time.now
      task.stop.should == Time.now
      task.no_stop_from_previous_on_now.should be_true
    end

    it "should set stop to Time.now when using NOW on new task" do
      task = @valid_user.tasks.new
      task.now
      task.stop.should == Time.now
    end

    it "should set start to previous stop when using NOW on new task" do
      prev = @valid_user.tasks.create! :start => 5.minutes.ago, :stop => 4.minutes.ago
      task = @valid_user.tasks.new
      task.now
      task.start.should be < Time.now
      task.start.should == prev.stop
      task.no_stop_from_previous_on_now.should be_false
    end
  end

end
