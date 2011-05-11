require 'spec_helper'

include Devise::TestHelpers
include AuthenticationHelperMethods

describe TagsController do

  describe "Sign in as user" do
    before :each do
      controller.stub!(:authenticate_user!).and_return(true)
      sign_in create_user
    end

    def mock_tag(stubs={})
      @mock_tag ||= mock_model(Tag, stubs).as_null_object
    end

    describe "GET index" do
      it "assigns all tags as @tags" do
        controller.stub_chain(:current_user, :tags, :all) { [mock_tag] }
        get :index
        assigns(:tags).should eq([mock_tag])
      end
    
      it "should require authentication" do
        controller.should_receive(:authenticate_user!)
        get :index
      end
    end

    describe "GET show" do
      it "assigns the requested tag as @tag" do
        controller.stub_chain(:current_user, :tags, :find).with('37') { mock_tag }
        get :show, :id => "37"
        assigns(:tag).should be(mock_tag)
      end
    end

    describe "GET new" do
      it "assigns a new tag as @tag" do
        controller.stub_chain(:current_user, :tags, :new) { mock_tag }
        get :new
        assigns(:tag).should be(mock_tag)
      end
    end

    describe "GET edit" do
      it "assigns the requested tag as @tag" do
        controller.stub_chain(:current_user, :tags, :find).with('37') { mock_tag }
        get :edit, :id => "37"
        assigns(:tag).should be(mock_tag)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "assigns a newly created tag as @tag" do
          controller.stub_chain(:current_user, :tags, :new).with({'name' => 'Education'}) { mock_tag(:save => true) }
          controller.current_user.stub(:id).and_return(1)
          
          post :create, :tag => {'name' => 'Education'}
          assigns(:tag).should be(mock_tag)
        end
      
        it "adds the current_user to @tag" do
          # controller.stub_chain(:current_user, :tags, :new).with({ }) { mock_tag('user_id' => 1, :save => true) }
          # controller.current_user.should_receive(:id).and_return(1)
          current_user  = double('current_user')
          tags          = double('tags')
          current_user.stub(:tags).and_return(tags)
          current_user.should_receive(:id).and_return(1)
          tags.stub(:new).with({ }) { mock_tag('user_id' => 1, :save => true) }
          controller.stub(:current_user).and_return(current_user)

          controller.should_receive(:current_user).and_return(current_user)
          post :create, :tag => { }
          assigns(:tag).should be(mock_tag)
        end

        it "redirects to the created tag" do
          controller.stub_chain(:current_user, :tags, :new) { mock_tag(:save => true) }
          controller.current_user.stub(:id).and_return(1)

          post :create, :tag => {}
          response.should redirect_to(tag_url(mock_tag))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved tag as @tag" do
          # controller.stub_chain(:current_user, :tags, :new).with({'name' => 'Education'}) { mock_tag(:save => false) }
          current_user  = double('current_user')
          tags          = double('tags')
          current_user.stub(:tags).and_return(tags)
          current_user.stub(:id).and_return(1)
          tags.stub(:new).with({'name' => 'Education'}) { mock_tag(:save => false) }
          controller.stub(:current_user).and_return(current_user)

          post :create, :tag => {'name' => 'Education'}
          assigns(:tag).should be(mock_tag)
        end

        it "re-renders the 'new' template" do
          # controller.stub_chain(:current_user, :tags, :new) { mock_tag(:save => false) }
          current_user  = double('current_user')
          tags          = double('tags')
          current_user.stub(:tags).and_return(tags)
          current_user.stub(:id).and_return(1)
          tags.stub(:new) { mock_tag(:save => false) }
          controller.stub(:current_user).and_return(current_user)

          post :create, :tag => {}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested tag" do
          controller.stub_chain(:current_user, :tags, :find).with("37") { mock_tag }
          mock_tag.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :tag => {'these' => 'params'}
        end

        it "assigns the requested tag as @tag" do
          controller.stub_chain(:current_user, :tags, :find) { mock_tag(:update_attributes => true) }
          put :update, :id => "1"
          assigns(:tag).should be(mock_tag)
        end

        it "redirects to the tag" do
          controller.stub_chain(:current_user, :tags, :find) { mock_tag(:update_attributes => true) }
          put :update, :id => "1"
          response.should redirect_to(tag_url(mock_tag))
        end
      end

      describe "with invalid params" do
        it "assigns the tag as @tag" do
          controller.stub_chain(:current_user, :tags, :find) { mock_tag(:update_attributes => false) }
          put :update, :id => "1"
          assigns(:tag).should be(mock_tag)
        end

        it "re-renders the 'edit' template" do
          controller.stub_chain(:current_user, :tags, :find) { mock_tag(:update_attributes => false) }
          put :update, :id => "1"
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested tag" do
        controller.stub_chain(:current_user, :tags, :find).with("37") { mock_tag }
        mock_tag.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "redirects to the tags list" do
        controller.stub_chain(:current_user, :tags, :find) { mock_tag }
        delete :destroy, :id => "1"
        response.should redirect_to(tags_url)
      end
    end
    
  end
end
