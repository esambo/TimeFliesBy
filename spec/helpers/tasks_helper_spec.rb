require 'spec_helper'

describe TasksHelper do

  #Delete this example and add some real ones or delete this file
  it "is included in the helper object" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(TasksHelper)
  end
  
  describe "#human_duration" do
    it "should use a short and readable format" do
      human_duration(123).should == '2m 3s'
    end
    
    it "should work with 0 seconds" do
      human_duration(0).should == '0s'
    end
  end
  
  describe "#microformats_duration" do
    it "should be iso8601" do
      microformats_duration(123).should == 'PT2M3S'
    end
    
    it "should work with 0 seconds" do
      microformats_duration(0).should == 'P'
    end
  end
  
  describe "#human_datetime" do
    it "should use normal US format" do
      human_datetime(Time.zone.parse("11 Apr 2011 06:14:01 CDT -05:00")).should == '4/11/2011 06:14:01'
    end
    
    it "should handle nil" do
      human_datetime(nil).should == 'Active'
    end
  end
  
  describe "#editable_datetime" do
    it "should use normal US format" do
      editable_datetime(Time.zone.parse("11 Apr 2011 06:14:01 CDT -05:00")).should == '4/11/2011 06:14:01'
    end
    
    it "should show 'Active' when blank" do
      editable_datetime(nil).should == nil
    end
  end
  
  describe "#microformats_datetime" do
    it "should be iso8601" do
      microformats_datetime(Time.zone.parse("11 Apr 2011 06:14:01 CDT -05:00")).should == '2011-04-11T06:14:01-05:00'
    end
    
    it "should handle nil" do
      microformats_datetime(nil).should == nil
    end
  end

end
