require 'spec_helper'

describe "tasks/new.html.erb" do
  before(:each) do
    assign(:task, stub_model(Task,
      :title => "MyString",
      :description => "MyText"
    ).as_new_record)
    assign(:tags, [stub_model(Tag), stub_model(Tag)])
  end

  it "renders new task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tasks_path, :method => "post" do
      assert_select "input#task_title", :name => "task[title]"
      assert_select "textarea#task_description", :name => "task[description]"
    end
  end
end
