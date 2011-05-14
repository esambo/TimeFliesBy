require 'spec_helper'

describe TasksController do

  include Devise::TestHelpers
  include AuthenticationHelperMethods
  
  describe "Sign in as user" do
    before :each do
      controller.stub!(:authenticate_user!).and_return(true)
      sign_in create_user
    end

    def mock_task(stubs={})
      @mock_task ||= mock_model(Task, stubs) #.as_null_object
    end

    describe "GET index" do
      it "assigns all tasks as @tasks" do
      # Task.stub(:all) { [mock_task] }
        controller.stub_chain(:current_user, :tasks, :all) { [mock_task] }
        get :index
        assigns(:tasks).should eq([mock_task])
      end
    end

    describe "GET show" do
      it "assigns the requested task as @task" do
      # Task.stub(:find).with("37") { mock_task }
        controller.stub_chain(:current_user, :tasks, :find).with('37') { mock_task }
        get :show, :id => "37"
        assigns(:task).should be(mock_task)
      end
    end

    describe "GET new" do
      it "assigns a new task as @task" do
      # Task.stub(:new) { mock_task }
        controller.stub_chain(:current_user, :tasks, :new) { mock_task }
        controller.stub_chain(:current_user, :tags,  :all) { }
        get :new
        assigns(:task).should be(mock_task)
      end
      
      it "assigns all tags to @tags" do
        tags = [mock_model(Tag), mock_model(Tag)]
        controller.stub_chain(:current_user, :tasks, :new) { mock_task }
        controller.stub_chain(:current_user, :tags,  :all) { tags }
        controller.current_user.tags.should_receive(:all) { tags }
        get :new
        assigns(:tags).should == tags
      end
    end

    describe "GET edit" do
      it "assigns the requested task as @task" do
      # Task.stub(:find).with("37") { mock_task }
        controller.stub_chain(:current_user, :tasks, :find).with('37') { mock_task }
        controller.stub_chain(:current_user, :tags, :all) { }
        get :edit, :id => "37"
        assigns(:task).should be(mock_task)
      end
      
      it "assigns all tags to @tags" do
        tags = [mock_model(Tag), mock_model(Tag)]
        controller.stub_chain(:current_user, :tasks, :find).with('37') { mock_task }
        controller.stub_chain(:current_user, :tags, :all) { tags }
        controller.current_user.tags.should_receive(:all) { tags }
        get :edit, :id => "37"
        assigns(:tags).should == tags
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "assigns a newly created task as @task" do
          start = Time.now
        # Task.stub(:new).with({'start' => start}) { mock_task(:save => true) }
          controller.stub_chain(:current_user, :tasks, :new).with('start' => start) { mock_task(:save => true, :start => start) }
          @controller.instance_eval{flash.stub!(:sweep)}
          post :create, :task => {'start' => start}
          assigns(:task).should be(mock_task)
          flash.should include(:notice => 'Task was successfully created.')
        end

        it "calls Task#switch_now when SWITCH is used" do
        # Task.stub(:new) { mock_task(:save => true) }
          task = mock_task(:save => true)
          task.should_receive(:switch_now)
          controller.stub_chain(:current_user, :tasks, :new) { task }
          post :create, :commit => 'Switch Now'
        end

        it "redirects to the created task" do
        # Task.stub(:new) { mock_task(:save => true) }
          controller.stub_chain(:current_user, :tasks, :new) { mock_task(:save => true) }
          post :create, :task => {}
          response.should redirect_to(task_url(mock_task))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved task as @task" do
        # Task.stub(:new).with({'these' => 'params'}) { mock_task(:save => false) }
          controller.stub_chain(:current_user, :tasks, :new).with('these' => 'params') { mock_task(:save => false) }
          controller.stub_chain(:current_user, :tags,  :all) { }
          post :create, :task => {'these' => 'params'}
          assigns(:task).should be(mock_task)
        end

        it "re-renders the 'new' template" do
        # Task.stub(:new) { mock_task(:save => false) }
          controller.stub_chain(:current_user, :tasks, :new) { mock_task(:save => false) }
          controller.stub_chain(:current_user, :tags,  :all) { }
          post :create, :task => {}
          response.should render_template("new")
        end
        
        it "assigns all tags to @tags" do
          tags = [mock_model(Tag), mock_model(Tag)]
          controller.stub_chain(:current_user, :tasks, :new) { mock_task(:save => false) }
          controller.stub_chain(:current_user, :tags,  :all) { tags }
          controller.current_user.tags.should_receive(:all) { tags }
          post :create, :task => {}
          assigns(:tags).should == tags
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested task" do
        # Task.stub(:find).with("37") { mock_task }
          task = mock_task(:update_attributes => true)
          task.should_receive(:update_attributes).with({'these' => 'params'}).and_return(true)
          controller.stub_chain(:current_user, :tasks, :find).with('37') { task }
         put :update, :id => "37", :task => {'these' => 'params'}
        end

        it "assigns the requested task as @task" do
        # Task.stub(:find) { mock_task(:update_attributes => true) }
          controller.stub_chain(:current_user, :tasks, :find) { mock_task(:update_attributes => true) }
          put :update, :id => "1"
         assigns(:task).should be(mock_task)
       end

        it "redirects to the task" do
        # Task.stub(:find) { mock_task(:update_attributes => true) }
          controller.stub_chain(:current_user, :tasks, :find) { mock_task(:update_attributes => true) }
          put :update, :id => "1"
          response.should redirect_to(task_url(mock_task))
        end
      end

      describe "with invalid params" do
        it "assigns the task as @task" do
        # Task.stub(:find) { mock_task(:update_attributes => false) }
          controller.stub_chain(:current_user, :tasks, :find) { mock_task(:update_attributes => false) }
          controller.stub_chain(:current_user, :tags,  :all) { }
          put :update, :id => "1"
          assigns(:task).should be(mock_task)
        end

        it "re-renders the 'edit' template" do
        # Task.stub(:find) { mock_task(:update_attributes => false) }
          controller.stub_chain(:current_user, :tasks, :find) { mock_task(:update_attributes => false) }
          controller.stub_chain(:current_user, :tags,  :all) { }
          put :update, :id => "1"
          response.should render_template("edit")
        end
        
        it "assigns all tags to @tags" do
          tags = [mock_model(Tag), mock_model(Tag)]
          controller.stub_chain(:current_user, :tasks, :find) { mock_task(:update_attributes => false) }
          controller.stub_chain(:current_user, :tags,  :all) { tags }
          controller.current_user.tags.should_receive(:all) { tags }
          put :update, :id => "1"
          assigns(:tags).should == tags
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested task" do
      # Task.stub(:find).with("37") { mock_task }
        controller.stub_chain(:current_user, :tasks, :find).with('37') { mock_task }
        mock_task.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "redirects to the tasks list" do
      # Task.stub(:find) { mock_task }
        controller.stub_chain(:current_user, :tasks, :find) { mock_task }
        delete :destroy, :id => "1"
        response.should redirect_to(tasks_url)
      end
    end

  end

end
