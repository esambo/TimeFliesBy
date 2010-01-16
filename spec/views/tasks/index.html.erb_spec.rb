require 'spec_helper'

describe "/tasks/index.html.erb" do
  include TasksHelper

  before(:each) do
    assigns[:tasks] = [
      stub_model(Task,
        :title => "value for title",
        :description => "value for description"
      ),
      stub_model(Task,
        :title => "value for title",
        :description => "value for description"
      )
    ]
  end

  it "renders a list of tasks" do
    render
    response.should have_tag("tr>td", "value for title".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
  end
end