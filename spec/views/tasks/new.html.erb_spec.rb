require 'spec_helper'

describe "/tasks/new.html.erb" do
  include TasksHelper

  before(:each) do
    assigns[:task] = stub_model(Task,
      :new_record? => true,
      :title => "value for title",
      :description => "value for description"
    )
  end

  it "renders new task form" do
    render

    response.should have_tag("form[action=?][method=post]", tasks_path) do
      with_tag("input#task_title[name=?]", "task[title]")
      with_tag("textarea#task_description[name=?]", "task[description]")
    end
  end
end
