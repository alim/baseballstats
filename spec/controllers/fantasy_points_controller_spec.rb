require 'spec_helper'

describe FantasyPointsController do
    
  let(:valid_attributes) {
    {
      home_run: 4,
      rbi: 3,
      stolen_base: 2,
      caught_stealing: 1,
    }
  }
        
  describe "GET index" do
    it "should redirect to show action if FantasyPoint model exists" do
      fantasy_point = FactoryGirl.create(:fantasy_point)
      get :index
      response.should redirect_to fantasy_point_url(fantasy_point)
    end
    
    it "should redirect to new action if FantasyPoint model does NOT exists" do
      get :index
      response.should redirect_to new_fantasy_point_url
    end    
  end

  describe "GET show" do
    it "assigns the requested fantasy_point as @fantasy_point" do
      fantasy_point = FactoryGirl.create(:fantasy_point)    
      get :show, {id: fantasy_point.to_param}
      assigns(:fantasy_point).should eq(fantasy_point)
    end
  end

  describe "GET new" do
    it "assigns a new fantasy_point as @fantasy_point" do
      get :new
      assigns(:fantasy_point).should be_a_new(FantasyPoint)
    end
  end

  describe "GET edit" do
    it "assigns the requested fantasy_point as @fantasy_point" do
      fantasy_point = FactoryGirl.create(:fantasy_point)    
      get :edit, {id: fantasy_point.to_param}
      assigns(:fantasy_point).should eq(fantasy_point)
    end
  end

  describe "POST create" do
    describe "with valid params" do

      it "creates a new FantasyPoint" do
        expect {
          post :create, {fantasy_point: valid_attributes}
        }.to change(FantasyPoint, :count).by(1)
      end

      it "assigns a newly created fantasy_point as @fantasy_point" do
        post :create, {fantasy_point: valid_attributes}
        assigns(:fantasy_point).should be_a(FantasyPoint)
        assigns(:fantasy_point).should be_persisted
      end

      it "redirects to the created fantasy_point" do
        post :create, {fantasy_point: valid_attributes}
        response.should redirect_to(FantasyPoint.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved fantasy_point as @fantasy_point" do
        # Trigger the behavior that occurs when invalid params are submitted
        FantasyPoint.any_instance.stub(:save).and_return(false)
        post :create, {:fantasy_point => { "home_run" => "invalid value" }}
        assigns(:fantasy_point).should be_a_new(FantasyPoint)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        FantasyPoint.any_instance.stub(:save).and_return(false)
        post :create, {:fantasy_point => { "home_run" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
   before(:each){
      @fantasy_point = FactoryGirl.create(:fantasy_point) 
    }
    
    describe "with valid params" do
      
      it "updates the requested fantasy_point" do
        # Assuming there are no other fantasy_points in the database, this
        # specifies that the FantasyPoint created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        FantasyPoint.any_instance.should_receive(:update).with({ "home_run" => '10' })
        put :update, {id: @fantasy_point.to_param, fantasy_point: { "home_run" => '10' }}
      end

      it "assigns the requested fantasy_point as @fantasy_point" do
        put :update, {id: @fantasy_point.to_param, fantasy_point: valid_attributes}
        assigns(:fantasy_point).should eq(@fantasy_point)
      end

      it "redirects to the fantasy_point" do
        put :update, {id: @fantasy_point.to_param, fantasy_point: valid_attributes}
        response.should redirect_to(@fantasy_point)
      end
    end

    describe "with invalid params" do
      it "assigns the fantasy_point as @fantasy_point" do
        # Trigger the behavior that occurs when invalid params are submitted
        FantasyPoint.any_instance.stub(:save).and_return(false)
        put :update, {id: @fantasy_point.to_param, fantasy_point: { "home_run" => "invalid value" }}
        assigns(:fantasy_point).should eq(@fantasy_point)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        FantasyPoint.any_instance.stub(:save).and_return(false)
        put :update, {id: @fantasy_point.to_param, fantasy_point: { "home_run" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each){
      @fantasy_point = FactoryGirl.create(:fantasy_point)    
    }

    it "destroys the requested fantasy_point" do
      expect {
        delete :destroy, {id: @fantasy_point.to_param}
      }.to change(FantasyPoint, :count).by(-1)
    end

    it "redirects to the fantasy_points list" do
      delete :destroy, {id: @fantasy_point.to_param}
      response.should redirect_to(fantasy_points_url)
    end
  end

end
