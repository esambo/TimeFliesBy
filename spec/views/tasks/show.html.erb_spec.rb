require 'spec_helper'

describe "tasks/show.html.erb" do
  before(:each) do
    @task = assign(:task, stub_model(Task))
  end

  it "renders attributes in <p>" do
    render
  end
end
