require 'rails_helper'

RSpec.describe PicturesController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET init" do
    it "returns http success" do
      get :init
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    it "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end

    context "with valid params" do
      specify "add a picture" do
        params = { path: Rails.root.join('spec/dummy_pictures/exif-full.jpg').to_s }
        expect { post :create, params }.to change(Picture, :count).by(1)
      end
    end
  end
end
