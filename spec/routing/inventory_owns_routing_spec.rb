require "spec_helper"

describe InventoryOwnsController do
  describe "routing" do

    it "routes to #index" do
      get("/inventory_owns").should route_to("inventory_owns#index")
    end

    it "routes to #new" do
      get("/inventory_owns/new").should route_to("inventory_owns#new")
    end

    it "routes to #show" do
      get("/inventory_owns/1").should route_to("inventory_owns#show", :id => "1")
    end

    it "routes to #edit" do
      get("/inventory_owns/1/edit").should route_to("inventory_owns#edit", :id => "1")
    end

    it "routes to #create" do
      post("/inventory_owns").should route_to("inventory_owns#create")
    end

    it "routes to #update" do
      put("/inventory_owns/1").should route_to("inventory_owns#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/inventory_owns/1").should route_to("inventory_owns#destroy", :id => "1")
    end

  end
end
