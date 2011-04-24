require 'spec_helper'

describe "Tags" do
  describe "GET /tags" do
    it "redirects on unauthorized access" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get tags_path
      response.status.should be(302)
    end
  end
end
