require 'rails_helper'

RSpec.describe BodiesController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, params = { id: FactoryGirl.create(:body).id }
      expect(response).to have_http_status(:success)
    end
  end

end
