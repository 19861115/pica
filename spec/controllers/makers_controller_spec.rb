require 'rails_helper'

RSpec.describe MakersController, type: :controller do
  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET show' do
    it 'returns http success' do
      params = { id: FactoryGirl.create(:maker).id }
      get :show, params
      expect(response).to have_http_status(:success)
    end
  end
end
