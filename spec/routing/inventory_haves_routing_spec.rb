require "spec_helper"

describe InventoryHavesController do
  describe "routing" do

    it "routes to #index" do
      get("/inventory_haves").should route_to("inventory_haves#index")
    end

    it "routes to #new" do
      get("/inventory_haves/new").should route_to("inventory_haves#new")
    end

    it "routes to #show" do
      get("/inventory_haves/1").should route_to("inventory_haves#show", :id => "1")
    end

    it "routes to #edit" do
      get("/inventory_haves/1/edit").should route_to("inventory_haves#edit", :id => "1")
    end

    it "routes to #create" do
      post("/inventory_haves").should route_to("inventory_haves#create")
    end

    it "routes to #update" do
      put("/inventory_haves/1").should route_to("inventory_haves#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/inventory_haves/1").should route_to("inventory_haves#destroy", :id => "1")
    end

  end
end
