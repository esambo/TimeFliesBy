require 'spec_helper'

describe TasksHelper do

  describe "#human_date_time" do
    it "should use normal US format" do
      human_date_time(Time.zone.parse("11 Apr 2011 06:14:01 CDT -05:00")).should == '4/11/2011 06:14:01'
    end

    it "should show 'Active' when empty" do
      human_date_time(nil).should == 'Active'
    end
  end

end
