require "spec_helper"

describe TradeLinesController do
  describe "routing" do

    it "routes to #index" do
      get("/trade_lines").should route_to("trade_lines#index")
    end

    it "routes to #new" do
      get("/trade_lines/new").should route_to("trade_lines#new")
    end

    it "routes to #show" do
      get("/trade_lines/1").should route_to("trade_lines#show", :id => "1")
    end

    it "routes to #edit" do
      get("/trade_lines/1/edit").should route_to("trade_lines#edit", :id => "1")
    end

    it "routes to #create" do
      post("/trade_lines").should route_to("trade_lines#create")
    end

    it "routes to #update" do
      put("/trade_lines/1").should route_to("trade_lines#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/trade_lines/1").should route_to("trade_lines#destroy", :id => "1")
    end

  end
end
