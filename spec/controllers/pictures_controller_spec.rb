require 'rails_helper'

RSpec.describe PicturesController, type: :controller do

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET show' do
    it 'returns http success' do
      params = { id: FactoryGirl.create(:picture).id }
      get :show, params
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET init' do
    it 'returns http success' do
      get :init
      expect(response).to have_http_status(:success)
    end

    context 'with valid filepath' do
      before do
        Picture.delete_all
        @path = Rails.root.join('spec/dummy_pictures/')
        @params = { path: @path.to_s }
      end

      specify 'add a picture(s)' do
        count = Dir.glob(@path.join('**/*.{JPG,JPEG,jpg,jpeg}').to_s).count
        expect { post :init, @params }.to change(Picture, :count).by(count)
      end

      specify 'render index template' do
        post :init, @params
        expect(response).to render_template('index')
      end
    end

    context 'with invalid filepath' do
      before { @params = { path: dummy_picture_path('not-exist-directory') } }

      specify 'not add a picture' do
        expect { post :init, @params }.not_to change(Picture, :count)
      end

      specify 'render index template' do
        post :init, @params
        expect(response).to render_template('index')
      end
    end

    context 'with no filepath' do
      specify 'not add a picture' do
        expect { post :init }.not_to change(Picture, :count)
      end

      specify 'render index template' do
        post :init
        expect(response).to render_template('index')
      end
    end
  end

  describe 'POST create' do
    it 'returns http success' do
      post :create
      expect(response).to have_http_status(:success)
    end

    context 'with valid filepath' do
      before do
        Picture.delete_all
        @params = { path: dummy_picture_path('exif-full.jpg') }
      end

      specify 'add a picture' do
        expect { post :create, @params }.to change(Picture, :count).by(1)
      end

      specify 'render show template' do
        post :create, @params
        expect(response).to render_template('show')
      end
    end

    context 'with registered filepath' do
      before do
        Picture.delete_all
        path =  dummy_picture_path('exif-full.jpg')
        FactoryGirl.create(:picture, path: path)
        @params = { path: path }
      end

      specify 'not add a picture' do
        expect { post :create, @params }.not_to change(Picture, :count)
      end

      specify 'render show template' do
        post :create, @params
        expect(response).to render_template('show')
      end
    end

    context 'with invalid filepath' do
      before { @params = { path: dummy_picture_path('not-exist-file') } }

      specify 'not add a picture' do
        expect { post :create, @params }.not_to change(Picture, :count)
      end

      specify 'render new template' do
        post :create, @params
        expect(response).to render_template('new')
      end
    end

    context 'with no filepath' do
      specify 'not add a picture' do
        expect { post :create }.not_to change(Picture, :count)
      end

      specify 'render new template' do
        post :create
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET charts' do
    Picture.delete_all
    it 'returns http success' do
      get :charts
      expect(response).to have_http_status(:success)
    end
  end
end
