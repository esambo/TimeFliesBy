require 'spec_helper'

describe WelcomeController do

  describe "Not Sign in as user" do

    describe "GET index" do
      it "Render template" do
        get :index
        response.should render_template("index")
      end
    end

  end

end
