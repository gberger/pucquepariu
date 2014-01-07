require 'spec_helper'

describe "study_materials/show" do
  before(:each) do
    @study_material = assign(:study_material, stub_model(StudyMaterial))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
