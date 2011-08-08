require 'spec_helper'

describe DateTimeHelper do

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
  
  describe "#editable_date_time" do
    it "should use normal US format" do
      editable_date_time(Time.zone.parse("11 Apr 2011 06:14:01 CDT -05:00")).should == '4/11/2011 06:14:01'
    end
    
    it "should show 'Active' when blank" do
      editable_date_time(nil).should == nil
    end
  end
  
  describe "#microformats_date_time" do
    it "should be iso8601" do
      microformats_date_time(Time.zone.parse("11 Apr 2011 06:14:01 CDT -05:00")).should == '2011-04-11T06:14:01-05:00'
    end
    
    it "should handle nil" do
      microformats_date_time(nil).should == nil
    end
  end
  
  describe "#parse_human_duration" do
    it "should parse duration into seconds" do
      parse_human_duration('1m 9s').should == 69
    end
    
    it "should return 0 instead of nil" do
      parse_human_duration('0s').should == 0
    end
  end
  
  describe "#parse_us_date_time" do
    it "does NOT use US date format in Ruby 1.9 by default" do
      Date.parse('4/1/2000 13:00').month.should_not == 4
    end
    
    it "does NOT use US date_time format in Ruby 1.9by default" do
      DateTime.parse('4/1/2000 13:00').month.should_not == 4
    end
    
    it "parses dates from the US m/d/yy format" do
      parse_us_date_time('4/1/2000 13:00').month.should == 4
    end
  end

end
