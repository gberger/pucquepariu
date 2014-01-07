require 'spec_helper'

describe "study_materials/edit" do
  before(:each) do
    @study_material = assign(:study_material, stub_model(StudyMaterial))
  end

  it "renders the edit study_material form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", study_material_path(@study_material), "post" do
    end
  end
end
