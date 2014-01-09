require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe StudyMaterialsController do

  # This should return the minimal set of attributes required to create a valid
  # StudyMaterial. As you add validations to StudyMaterial, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StudyMaterialsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all study_materials as @study_materials" do
      study_material = StudyMaterial.create! valid_attributes
      get :index, {}, valid_session
      assigns(:study_materials).should eq([study_material])
    end
  end

  describe "GET show" do
    it "assigns the requested study_material as @study_material" do
      study_material = StudyMaterial.create! valid_attributes
      get :show, {:id => study_material.to_param}, valid_session
      assigns(:study_material).should eq(study_material)
    end
  end

  describe "GET new" do
    it "assigns a new study_material as @study_material" do
      get :new, {}, valid_session
      assigns(:study_material).should be_a_new(StudyMaterial)
    end
  end

  describe "GET edit" do
    it "assigns the requested study_material as @study_material" do
      study_material = StudyMaterial.create! valid_attributes
      get :edit, {:id => study_material.to_param}, valid_session
      assigns(:study_material).should eq(study_material)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new StudyMaterial" do
        expect {
          post :create, {:study_material => valid_attributes}, valid_session
        }.to change(StudyMaterial, :count).by(1)
      end

      it "assigns a newly created study_material as @study_material" do
        post :create, {:study_material => valid_attributes}, valid_session
        assigns(:study_material).should be_a(StudyMaterial)
        assigns(:study_material).should be_persisted
      end

      it "redirects to the created study_material" do
        post :create, {:study_material => valid_attributes}, valid_session
        response.should redirect_to(StudyMaterial.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved study_material as @study_material" do
        # Trigger the behavior that occurs when invalid params are submitted
        StudyMaterial.any_instance.stub(:save).and_return(false)
        post :create, {:study_material => {  }}, valid_session
        assigns(:study_material).should be_a_new(StudyMaterial)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        StudyMaterial.any_instance.stub(:save).and_return(false)
        post :create, {:study_material => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested study_material" do
        study_material = StudyMaterial.create! valid_attributes
        # Assuming there are no other study_materials in the database, this
        # specifies that the StudyMaterial created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        StudyMaterial.any_instance.should_receive(:update).with({ "these" => "params" })
        put :update, {:id => study_material.to_param, :study_material => { "these" => "params" }}, valid_session
      end

      it "assigns the requested study_material as @study_material" do
        study_material = StudyMaterial.create! valid_attributes
        put :update, {:id => study_material.to_param, :study_material => valid_attributes}, valid_session
        assigns(:study_material).should eq(study_material)
      end

      it "redirects to the study_material" do
        study_material = StudyMaterial.create! valid_attributes
        put :update, {:id => study_material.to_param, :study_material => valid_attributes}, valid_session
        response.should redirect_to(study_material)
      end
    end

    describe "with invalid params" do
      it "assigns the study_material as @study_material" do
        study_material = StudyMaterial.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        StudyMaterial.any_instance.stub(:save).and_return(false)
        put :update, {:id => study_material.to_param, :study_material => {  }}, valid_session
        assigns(:study_material).should eq(study_material)
      end

      it "re-renders the 'edit' template" do
        study_material = StudyMaterial.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        StudyMaterial.any_instance.stub(:save).and_return(false)
        put :update, {:id => study_material.to_param, :study_material => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested study_material" do
      study_material = StudyMaterial.create! valid_attributes
      expect {
        delete :destroy, {:id => study_material.to_param}, valid_session
      }.to change(StudyMaterial, :count).by(-1)
    end

    it "redirects to the study_materials list" do
      study_material = StudyMaterial.create! valid_attributes
      delete :destroy, {:id => study_material.to_param}, valid_session
      response.should redirect_to(study_materials_url)
    end
  end

end