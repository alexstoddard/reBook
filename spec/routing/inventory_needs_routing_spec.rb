require "spec_helper"

describe InventoryNeedsController do
  describe "routing" do

    it "routes to #index" do
      get("/inventory_needs").should route_to("inventory_needs#index")
    end

    it "routes to #new" do
      get("/inventory_needs/new").should route_to("inventory_needs#new")
    end

    it "routes to #show" do
      get("/inventory_needs/1").should route_to("inventory_needs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/inventory_needs/1/edit").should route_to("inventory_needs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/inventory_needs").should route_to("inventory_needs#create")
    end

    it "routes to #update" do
      put("/inventory_needs/1").should route_to("inventory_needs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/inventory_needs/1").should route_to("inventory_needs#destroy", :id => "1")
    end

  end
end
