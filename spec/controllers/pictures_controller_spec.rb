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

    context "with exif-full.jpg" do
      before do
        params = { path: Rails.root.join('spec/dummy_pictures/exif-full.jpg').to_s }
        post :create, params
      end

      specify "set all exif-data" do
        picture = Picture.last
        expect(picture.path).not_to be_nil
        expect(picture.exposure_time).not_to be_nil
        expect(picture.f_number).not_to be_nil
        expect(picture.focal_length).not_to be_nil
        expect(picture.iso).not_to be_nil
      end
    end

    context "with no-exif.jpg" do
      before do
        params = { path: Rails.root.join('spec/dummy_pictures/no-exif.jpg').to_s }
        post :create, params
      end

      specify "set only path" do
        picture = Picture.last
        expect(picture.path).not_to be_nil
        expect(picture.exposure_time).to be_nil
        expect(picture.f_number).to be_nil
        expect(picture.focal_length).to be_nil
        expect(picture.iso).to be_nil
      end
    end
  end
end
