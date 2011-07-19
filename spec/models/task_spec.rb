require 'spec_helper'
include AuthenticationHelperMethods

describe Task do
  before(:each) do
    @valid_user = create_user(:email => 'valid_user@timefliesby.com')
    @valid_attributes = {
      :title        => "valid title",
      :description  => "valid description",
      :start        => Time.zone.now
    }
    @all_attributes = {
      :title        => "valid title",
      :description  => "valid description",
      :start        => 5.minutes.ago,
      :stop         => 3.minutes.ago,
      :created_at   => 5.minutes.ago,
      :updated_at   => 3.minutes.ago,
      :user_id      => @valid_user.id
    }
  end

  it "should only show tasks for the current user" do
    u1 = create_user(:email => 'models_test_user_3@timefliesby.com')
    Task.all.size.should == 0
    u1.tasks.create({:title => "Task 1 for user: 1", :start => 1.minutes.ago})
    Task.all.size.should == 1

    u2 = create_user(:email => 'models_test_user_2@timefliesby.com')
    u2.tasks.all.size.should == 0
    u2.tasks.create({:title => "Task 1 for user: 2", :start => 1.minute.ago})
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
  
  it "should not require stop" do
    t = @valid_user.tasks.new
    t.start = Time.zone.now
    t.should be_valid
    t.errors[:start].should be_blank
  end
  
  it "should use US date format for #start" do
    t = @valid_user.tasks.new
    t.start = '4/10/2011 20:42:56'
    t.start.month.should == 4
  end
  
  it "should use US date format for #stop" do
    t = @valid_user.tasks.new
    t.stop = '4/10/2011 21:25:00'
    t.stop.month.should == 4
  end

  it "should not validate for stop before start" do
    t = @valid_user.tasks.new
    t.start = Time.zone.now
    t.stop = 5.minutes.ago
    t.should_not be_valid
    t.errors[:stop].should_not be_blank
  end
  
  it "should not validate for 3 month old stop" do
    t = @valid_user.tasks.new
    t.start = 3.weeks.ago
    t.stop = 4.months.ago
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
    t.user_id = 9999
    t.should_not be_valid
    t.errors[:user].should_not be_blank
  end

  it "should create a valid task" do
    t = @valid_user.tasks.new
    t.start = 1.minutes.ago
    t.should be_valid
  end

  it "should retrieve tasks in descending order" do
    t1 = @valid_user.tasks.create!(:title => 'Oldest task', :start => 5.minutes.ago)
    t2 = @valid_user.tasks.create!(:title => 'Newest task', :start => 1.minutes.ago)
    ts = @valid_user.tasks.all
    ts.first.start.should > ts.last.start
  end
  
  context "with frozen time" do
    before :each do
      Time.now = "2010-01-03 9:13:23 AM" #freeze time using time_travel plugin
    end

    after :each do
      Time.now = nil #undo time_travel
    end

    context "#duration" do
      it "should be in seconds" do
       t = @valid_user.tasks.new
       t.start = 1.minute.ago
       t.duration.should == 60
      end

      it "should use the current time if stop is blank" do
       t = @valid_user.tasks.new
       t.start = 1.minute.ago
       t.save!   #just to be save
       t.reload  #just to be save
       t.duration.should == 60
      end
      
    end

    context "#switch_at" do
      it "should keep #stop at nil" do
        t = @valid_user.tasks.new
        t.switch_at Time.zone.now
        t.stop.should == nil
      end
      
      it "should set start to given time" do
        t = @valid_user.tasks.new
        t.switch_at 1.minute.ago
        t.start.should == 1.minute.ago
      end    
      
      # it "should throw :older_start if start is older than previous start" do
      #   pending do
      #   end
      # end
      # 
      # it "should throw :older_stop if stop is older than previous stop" do
      #   pending do
      #   end
      # end
      # 
      # it "should throw :newer_start if start is newer than previous start" do
      #   pending do
      #     prev_t = @valid_user.tasks.create! :start => 5.minutes.ago, :stop => 1.minute.ago
      # 
      #     t = @valid_user.tasks.new
      #     expect { t.switch_at 3.minutes.ago }.to throw_symbol(:newer_start, 2.minutes)
      #   end
      # end
      # 
      # it "should throw :newer_stop if stop is newer than previous stop" do
      #   pending do
      #   end
      # end
      # 
      # it "should throw :future_start if start is in the future (by more than 59sec?)" do
      #   pending do
      #   end
      # end
      # 
      # it "should throw :future_stop if stop is in the future (by more than 59sec?)" do
      #   pending do
      #   end
      # end
      
    end
    
    context "#switch_now" do
      it "should set start to now" do
        t = @valid_user.tasks.new
        t.switch_now
        t.start.should == Time.zone.now
      end      
    end

    context "#switch_to duplicates task into a new one" do
      it "duplicates attributes" do
        old_t = @valid_user.tasks.create!(@all_attributes)
        new_t = old_t.switch_to
        new_t.title.should        == old_t.title
        new_t.description.should  == old_t.description
      end

      it "duplicates user" do
        old_t = @valid_user.tasks.create!(@all_attributes)
        new_t = old_t.switch_to
        new_t.user_id.should      == old_t.user_id
      end

      it "updated timestamps" do
        old_t = @valid_user.tasks.create!(@all_attributes)
        new_t = old_t.switch_to
        new_t.created_at.should   == Time.zone.now
        new_t.modified_at.should  == Time.zone.now
      end

      it "makes it the new task" do
        old_t = @valid_user.tasks.create!(@all_attributes)
        new_t = old_t.switch_to
        new_t.start.should        == Time.zone.now
      end

      it "makes it the active task" do
        old_t = @valid_user.tasks.create!(@all_attributes)
        new_t = old_t.switch_to
        new_t.stop.should         == nil
      end

      it "gets a new id" do
        old_t = @valid_user.tasks.create!(@all_attributes)
        new_t = old_t.switch_to
        new_t.id.should_not       == old_t.id
      end

      it "should be valid" do
        old_t = @valid_user.tasks.create!(@all_attributes)
        new_t = old_t.switch_to
        new_t.should              be_valid
      end

      it "should be new record" do
        old_t = @valid_user.tasks.create!(@all_attributes)
        new_t = old_t.switch_to
        new_t.should              be_new_record
      end

      it "duplicates tags" do
        old_t = @valid_user.tasks.create!(@all_attributes)
        books_tag = @valid_user.tags.create!(:name => 'books')
        ruby_tag  = @valid_user.tags.create!(:name => 'ruby')
        old_t.tags.push(books_tag)
        old_t.tags.push(ruby_tag)
        new_t = old_t.switch_to
        new_t.tags.map(&:name).should include(books_tag.name)
        new_t.tags.map(&:name).should include(ruby_tag.name)
      end
    end
    
    context "#set_stop_on_last" do
      it "should find task without a stop when creating new task" do
        prev_t = @valid_user.tasks.create! :start => 5.minutes.ago
      
        t = @valid_user.tasks.new
        t.switch_now
        t.save!
      
        prev_t.reload
        prev_t.stop.should == t.start
      end
      
      it "should work without a previous task" do
        t = @valid_user.tasks.new
        t.switch_now
        t.save!
      end
      
      it "should create a 'Error: Time gap!' task if the previous task already had a stop (which could happen since I don't use a transaction)" do
        prev_t = @valid_user.tasks.create! :start => 5.minutes.ago, :stop => 4.minutes.ago
      
        t = @valid_user.tasks.new
        t.switch_now
        t.save!
        t.reload
        t.start.should == Time.zone.now
        
        # gap_t = @valid_user.tasks.first(:order => "start DESC", :conditions => ["stop = ?", t.start.to_s(:db) + '.000000'])
        gap_t = @valid_user.tasks.first(:order => "start DESC", :conditions => ["stop = ?", t.start])
        gap_t.should be_kind_of Task
        gap_t.class.to_s.should == Task.to_s
        gap_t.title.should == 'Error: Time gap!'
        gap_t.start.should == 4.minutes.ago
        gap_t.stop.should == t.start
        gap_t.user_id.should == t.user_id
      end
      
    end

    it "should only use the current user" do
      prev_u = create_user(:email => 'models_test_user_2@timefliesby.com')
      prev_t = prev_u.tasks.create({:title => "Task 1 for user: 2", :start => 13.minutes.ago})

      t = @valid_user.tasks.new
      t.start = 1.minute.ago
      t.start.should == 1.minute.ago
      t.start.should_not == prev_t.start
    end

  end

end
