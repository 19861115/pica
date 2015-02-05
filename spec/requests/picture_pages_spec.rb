require 'rails_helper'

RSpec.describe "PicturePages", :type => :request do
  describe "GET /pictures" do
    it "page exists" do
      get pictures_path
      expect(response).to have_http_status(200)
    end

    specify "page title is 'Pictures'" do
      visit pictures_path
      expect(page).to have_title('Pictures')
      expect(page).to have_content('Pictures')
    end

    it "shows init form" do
      visit pictures_path
      expect(page).to have_field('Pictures path')
    end

    context 'when some pictures registered' do
      before do
        10.times { FactoryGirl.create(:picture) }
        visit pictures_path
      end

      specify "show registerd pictres" do
        picture = Picture.first
        expect(page).to have_content(picture.path)
        expect(page).to have_content(picture.exposure_time)
        expect(page).to have_content(picture.f_number)
        expect(page).to have_content(picture.focal_length)
        expect(page).to have_content(picture.iso)
        expect(page).to have_content(picture.body.name)
        expect(page).to have_content(picture.lens.name)
      end
    end

    context 'when no picture registered' do
      before do
        Picture.delete_all
        visit pictures_path
      end

      specify "show registerd pictres" do
        expect(page).to have_content('no picture')
      end
    end
  end
end
