require 'rails_helper'

RSpec.describe "PicturePages", :type => :request do
  describe "GET /pictures" do
    it "page exists" do
      get pictures_index_path
      expect(response).to have_http_status(200)
    end
  end
end
