require "spec_helper"

describe UserLocationsController do
  describe "routing" do

    it "routes to #index" do
      get("/user_locations").should route_to("user_locations#index")
    end

    it "routes to #new" do
      get("/user_locations/new").should route_to("user_locations#new")
    end

    it "routes to #show" do
      get("/user_locations/1").should route_to("user_locations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_locations/1/edit").should route_to("user_locations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_locations").should route_to("user_locations#create")
    end

    it "routes to #update" do
      put("/user_locations/1").should route_to("user_locations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_locations/1").should route_to("user_locations#destroy", :id => "1")
    end

  end
end
