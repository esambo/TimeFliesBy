require 'spec_helper'
include AuthenticationHelperMethods

describe Tag do
  before(:each) do
    @valid_user = create_user(:email => 'valid_user@timefliesby.com')
    @valid_attributes = {
      :user_id  => @valid_user.id,
      :name     => "test tag name"
    }
  end

  it "should create a new instance given valid attributes" do
    Tag.create! @valid_attributes
  end
  
  it "should require #user_id" do
    t = Tag.new
    t.should_not be_valid
    t.errors[:user_id].should_not be_blank
  end
  
  it "should require #name" do
    t = Tag.new
    t.should_not be_valid
    t.errors[:name].should_not be_blank
  end

end
