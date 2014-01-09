require 'spec_helper'

describe "exams/index" do
  before(:each) do
    assign(:exams, [
      stub_model(Exam),
      stub_model(Exam)
    ])
  end

  it "renders a list of exams" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
