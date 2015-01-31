require 'rails_helper'

RSpec.describe Picture, :type => :model do
  before { @picture = FactoryGirl.build(:picture) }

  subject { @picture }

  specify { expect(subject).to respond_to(:path) }
  specify { expect(subject).to respond_to(:exposure_time) }
  specify { expect(subject).to respond_to(:f_number) }
  specify { expect(subject).to respond_to(:focal_length) }
  specify { expect(subject).to respond_to(:iso) }
  specify { expect(subject).to respond_to(:body) }
  specify { expect(subject).to respond_to(:lens) }

  describe '#path' do
    it 'can not be blank' do
      @picture.path = ' '
      expect(subject).not_to be_valid
    end
  end

  describe '#new' do
    context "'exif-full.jpg'" do
      specify 'set all exif-data' do
        picture = Picture.new(path: Rails.root.join('spec/dummy_pictures/exif-full.jpg').to_s)
        expect(picture.path).not_to be_nil
        expect(picture.exposure_time).not_to be_nil
        expect(picture.f_number).not_to be_nil
        expect(picture.focal_length).not_to be_nil
        expect(picture.iso).not_to be_nil
        expect(picture.body).not_to be_nil
        expect(picture.lens).not_to be_nil
      end
    end

    context "'no-exif.jpg'" do
      specify 'set only path' do
        picture = Picture.new(path: Rails.root.join('spec/dummy_pictures/no-exif.jpg').to_s)
        expect(picture.path).not_to be_nil
        expect(picture.exposure_time).to be_nil
        expect(picture.f_number).to be_nil
        expect(picture.focal_length).to be_nil
        expect(picture.iso).to be_nil
        expect(picture.body).to be_nil
        expect(picture.lens).to be_nil
      end
    end
  end
end
