require 'spec_helper'

describe "tasks/edit.html.erb" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :title => "MyString",
      :description => "MyText"
    ))
    @tags = assign(:tags, [stub_model(Tag), stub_model(Tag)])
  end

  it "renders the edit task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tasks_path(@task), :method => "post" do
      assert_select "input#task_title", :name => "task[title]"
      assert_select "textarea#task_description", :name => "task[description]"
    end
  end
end
