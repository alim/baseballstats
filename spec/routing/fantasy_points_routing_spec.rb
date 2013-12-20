require "spec_helper"

describe FantasyPointsController do
  describe "routing" do

    it "routes to #index" do
      get("/fantasy_points").should route_to("fantasy_points#index")
    end

    it "routes to #new" do
      get("/fantasy_points/new").should route_to("fantasy_points#new")
    end

    it "routes to #show" do
      get("/fantasy_points/1").should route_to("fantasy_points#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fantasy_points/1/edit").should route_to("fantasy_points#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fantasy_points").should route_to("fantasy_points#create")
    end

    it "routes to #update" do
      put("/fantasy_points/1").should route_to("fantasy_points#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fantasy_points/1").should route_to("fantasy_points#destroy", :id => "1")
    end

  end
end
