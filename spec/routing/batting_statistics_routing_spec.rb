require "spec_helper"

describe BattingStatisticsController do
  describe "routing" do

    it "routes to #index" do
      get("/batting_statistics").should route_to("batting_statistics#index")
    end

    it "routes to #new" do
      get("/batting_statistics/new").should route_to("batting_statistics#new")
    end

    it "routes to #show" do
      get("/batting_statistics/1").should route_to("batting_statistics#show", :id => "1")
    end

    it "routes to #edit" do
      get("/batting_statistics/1/edit").should route_to("batting_statistics#edit", :id => "1")
    end

    it "routes to #create" do
      post("/batting_statistics").should route_to("batting_statistics#create")
    end

    it "routes to #update" do
      put("/batting_statistics/1").should route_to("batting_statistics#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/batting_statistics/1").should route_to("batting_statistics#destroy", :id => "1")
    end
    
    it "routes to #import" do
      post("/batting_statistics/import").should route_to("batting_statistics#import")
    end

  end
end
