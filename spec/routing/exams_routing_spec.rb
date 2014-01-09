require "spec_helper"

describe ExamsController do
  describe "routing" do

    it "routes to #index" do
      get("/exams").should route_to("exams#index")
    end

    it "routes to #new" do
      get("/exams/new").should route_to("exams#new")
    end

    it "routes to #show" do
      get("/exams/1").should route_to("exams#show", :id => "1")
    end

    it "routes to #edit" do
      get("/exams/1/edit").should route_to("exams#edit", :id => "1")
    end

    it "routes to #create" do
      post("/exams").should route_to("exams#create")
    end

    it "routes to #update" do
      put("/exams/1").should route_to("exams#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/exams/1").should route_to("exams#destroy", :id => "1")
    end

  end
end
