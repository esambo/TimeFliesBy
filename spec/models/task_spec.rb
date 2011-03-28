require 'spec_helper'
include AuthenticationHelperMethods

describe Task do
  before(:each) do
    @valid_user = create_user(:email => 'valid_user@timefliesby.com')
    @valid_attributes = {
      :title => "valid title",
      :start => Time.zone.now,
      :stop => Time.zone.now,
      :description => "valid description"
    }
  end

  it "should only show tasks for the current user" do
    u1 = create_user(:email => 'models_test_user_3@timefliesby.com')
    Task.all.size.should == 0
    u1.tasks.create({:title => "Task 1 for user: 1", :start => 1.minutes.ago, :stop => Time.zone.now})
    Task.all.size.should == 1

    u2 = create_user(:email => 'models_test_user_2@timefliesby.com')
    u2.tasks.all.size.should == 0
    u2.tasks.create({:title => "Task 1 for user: 2", :start => 1.minute.ago, :stop => Time.zone.now})
    u2.tasks.all.size.should == 1
  end

  it "should create a new instance given valid attributes" do
    @valid_user.tasks.create!(@valid_attributes)
  end

  it "should require start" do
    t = @valid_user.tasks.new
    t.should_not be_valid
    t.errors[:start].should_not be_blank
  end

  it "should not validate for stop before start" do
    t = @valid_user.tasks.new
    t.start = Time.zone.now
    t.stop = 5.minutes.ago
    t.should_not be_valid
    t.errors[:stop].should_not be_blank
  end

  it "should require user" do
    t = Task.new
    t.should_not be_valid
    t.errors[:user].should_not be_blank
  end

  it "should require valid user" do
    t = @valid_user.tasks.new
    t.start = 1.minutes.ago
    t.stop = Time.zone.now
    t.user_id = 9999
    t.should_not be_valid
    t.errors[:user].should_not be_blank
  end

  it "should create a valid task" do
    t = @valid_user.tasks.new
    t.start = 1.minutes.ago
    t.stop = Time.zone.now
    t.should be_valid
  end

  it "calculates #duration in seconds" do
    t = @valid_user.tasks.new
    t.start = 1.minute.ago
    t.stop = Time.zone.now
    t.duration.should == 60
  end

  context "with frozen time" do
    before :each do
      Time.now = "2010-01-03 9:13:23 AM" #freeze time using time_travel plugin
    end

    after :each do
      Time.now = nil #undo time_travel
    end

    it "should set start and stop to Time.zone.now when using now() on the first task" do
      t = @valid_user.tasks.new
      t.now
      t.start.should == Time.zone.now
      t.stop.should == Time.zone.now
    end

    it "should set stop to Time.zone.now when using #now() on new task" do
      t = @valid_user.tasks.new
      t.now
      t.stop.should == Time.zone.now
    end

    it "should set start to previous stop when using #now() on new task" do
      prev_t = @valid_user.tasks.create! :start => 5.minutes.ago, :stop => 4.minutes.ago
      t = @valid_user.tasks.new
      t.now
      t.start.should be < Time.zone.now
      t.start.should == prev_t.stop
    end

    it "should update stop when using #now() on an existing task" do
      t = @valid_user.tasks.create! :start => 5.minutes.ago, :stop => 4.minutes.ago
      t.reload
      t.now
      t.start.should == 5.minutes.ago
      t.stop.should == Time.zone.now
      t.save!
    end

    it "should only use the current user for #now()" do
      prev_u = create_user(:email => 'models_test_user_2@timefliesby.com')
      prev_t = prev_u.tasks.create({:title => "Task 1 for user: 2", :start => 13.minutes.ago, :stop => 10.minutes.ago})

      t = @valid_user.tasks.new
      t.now
      t.start.should == Time.zone.now
      t.start.should_not == prev_t.stop
    end

  end

end
