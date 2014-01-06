require 'spec_helper'

describe SearchController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'improved'" do
    it "returns http success" do
      get 'improved'
      response.should be_success
    end
  end

  describe "GET 'slugging'" do
    it "returns http success" do
      get 'slugging'
      response.should be_success
    end
  end

  describe "GET 'fantasy_improved'" do
    it "returns http success" do
      get 'fantasy_improved'
      response.should be_success
    end
  end

  describe "GET 'triple_crown'" do
    it "returns http success" do
      get 'triple_crown'
      response.should be_success
    end
  end

end
