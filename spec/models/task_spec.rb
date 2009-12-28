require 'spec_helper'

describe Task do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :start => Time.now,
      :stop => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Task.create!(@valid_attributes)
  end
end
