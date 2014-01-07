require 'spec_helper'

describe "study_materials/new" do
  before(:each) do
    assign(:study_material, stub_model(StudyMaterial).as_new_record)
  end

  it "renders new study_material form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", study_materials_path, "post" do
    end
  end
end
