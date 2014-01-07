require "spec_helper"

describe StudyMaterialsController do
  describe "routing" do

    it "routes to #index" do
      get("/study_materials").should route_to("study_materials#index")
    end

    it "routes to #new" do
      get("/study_materials/new").should route_to("study_materials#new")
    end

    it "routes to #show" do
      get("/study_materials/1").should route_to("study_materials#show", :id => "1")
    end

    it "routes to #edit" do
      get("/study_materials/1/edit").should route_to("study_materials#edit", :id => "1")
    end

    it "routes to #create" do
      post("/study_materials").should route_to("study_materials#create")
    end

    it "routes to #update" do
      put("/study_materials/1").should route_to("study_materials#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/study_materials/1").should route_to("study_materials#destroy", :id => "1")
    end

  end
end
