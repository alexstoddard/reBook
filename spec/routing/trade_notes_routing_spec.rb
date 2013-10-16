require "spec_helper"

describe TradeNotesController do
  describe "routing" do

    it "routes to #index" do
      get("/trade_notes").should route_to("trade_notes#index")
    end

    it "routes to #new" do
      get("/trade_notes/new").should route_to("trade_notes#new")
    end

    it "routes to #show" do
      get("/trade_notes/1").should route_to("trade_notes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/trade_notes/1/edit").should route_to("trade_notes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/trade_notes").should route_to("trade_notes#create")
    end

    it "routes to #update" do
      put("/trade_notes/1").should route_to("trade_notes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/trade_notes/1").should route_to("trade_notes#destroy", :id => "1")
    end

  end
end
