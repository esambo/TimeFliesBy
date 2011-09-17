require 'spec_helper'

describe WelcomeController do

  describe "Not Sign in as user" do
    describe "GET 'index'" do
      it "should be successful" do
        get 'index'
        response.should be_success
      end
    end

  end

end
