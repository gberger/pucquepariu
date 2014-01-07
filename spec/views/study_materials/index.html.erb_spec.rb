require 'spec_helper'

describe "study_materials/index" do
  before(:each) do
    assign(:study_materials, [
      stub_model(StudyMaterial),
      stub_model(StudyMaterial)
    ])
  end

  it "renders a list of study_materials" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
