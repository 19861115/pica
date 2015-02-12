require 'rails_helper'

RSpec.describe 'PicturePages', type: :request do
  describe 'GET /pictures' do
    it 'page exists' do
      get pictures_path
      expect(response).to have_http_status(200)
    end

    specify "page title is 'Pictures'" do
      visit pictures_path
      expect(page).to have_title('Pictures')
      expect(page).to have_content('Pictures')
    end

    it 'shows init form' do
      visit pictures_path
      expect(page).to have_field('Pictures path')
    end

    context 'when some pictures registered' do
      before do
        10.times { FactoryGirl.create(:picture) }
        visit pictures_path
      end

      specify 'show registerd pictures' do
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

      specify 'show message' do
        expect(page).to have_content('no picture')
      end
    end
  end

  describe 'GET /charts' do
    before { Picture.delete_all }
    it 'page exists' do
      get charts_path
      expect(response).to have_http_status(200)
    end

    specify "page title is 'Charts'" do
      visit charts_path
      expect(page).to have_title('Charts')
      expect(page).to have_content('Charts')
    end

    context 'when some pictures registered' do
      before do
        params = { path: 'spec/dummy_pictures' }
        post pictures_init_path, params
      end

      specify 'show charts' do
        visit charts_path
        expect(page).to have_content("Pie chart of 'exposure time'")
        expect(page).to have_content("Pie chart of 'f number'")
        expect(page).to have_content("Pie chart of 'focal length'")
        expect(page).to have_content("Pie chart of 'iso'")
        expect(page).to have_content("Pie chart of 'body'")
        expect(page).to have_content("Pie chart of 'lens'")
      end
    end

    context 'when no picture registered' do
      specify 'show message' do
        visit charts_path
        expect(page).to have_content('no picture')
      end
    end
  end
end
