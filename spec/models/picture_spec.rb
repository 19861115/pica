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
      specify 'set default exif-data' do
        picture = Picture.new(path: Rails.root.join('spec/dummy_pictures/no-exif.jpg').to_s)
        expect(picture.path).not_to be_nil
        expect(picture.exposure_time).to eq('undefined')
        expect(picture.f_number).to eq('undefined')
        expect(picture.focal_length).to eq('undefined')
        expect(picture.iso).to eq('undefined')
        expect(picture.body.name).to eq('undefined')
        expect(picture.lens.name).to eq('undefined')
      end
    end

    context "'exif-no-exposuretime.jpg'" do
      specify 'set default exposuretime' do
        picture = Picture.new(path: Rails.root.join('spec/dummy_pictures/exif-no-exposuretime.jpg').to_s)
        expect(picture.exposure_time).to eq('undefined')
      end
    end

    context "'exif-no-fnumber.jpg'" do
      specify 'set default fnumber' do
        picture = Picture.new(path: Rails.root.join('spec/dummy_pictures/exif-no-fnumber.jpg').to_s)
        expect(picture.f_number).to eq('undefined')
      end
    end

    context "'exif-no-focallength.jpg'" do
      specify 'set default focallength' do
        picture = Picture.new(path: Rails.root.join('spec/dummy_pictures/exif-no-focallength.jpg').to_s)
        expect(picture.focal_length).to eq('undefined')
      end
    end

    context "'exif-no-iso.jpg'" do
      specify 'set default iso' do
        picture = Picture.new(path: Rails.root.join('spec/dummy_pictures/exif-no-iso.jpg').to_s)
        expect(picture.iso).to eq('undefined')
      end
    end

    context "'exif-no-make.jpg'" do
      specify 'set default body' do
        picture = Picture.new(path: Rails.root.join('spec/dummy_pictures/exif-no-make.jpg').to_s)
        expect(picture.body.name).not_to eq('undefined')
        expect(picture.body.maker.name).to eq('undefined')
      end
    end

    context "'exif-no-model.jpg'" do
      specify 'set default body' do
        picture = Picture.new(path: Rails.root.join('spec/dummy_pictures/exif-no-model.jpg').to_s)
        expect(picture.body.name).to eq('undefined')
        expect(picture.body.maker.name).not_to eq('undefined')
      end
    end

    context "'exif-no-lensmake.jpg'" do
      specify 'set default lens' do
        picture = Picture.new(path: Rails.root.join('spec/dummy_pictures/exif-no-lensmake.jpg').to_s)
        expect(picture.lens.name).not_to eq('undefined')
        expect(picture.lens.maker.name).to eq('undefined')
      end
    end

    context "'exif-no-lensmodel.jpg'" do
      specify 'set default lens' do
        picture = Picture.new(path: Rails.root.join('spec/dummy_pictures/exif-no-lensmodel.jpg').to_s)
        expect(picture.lens.name).to eq('undefined')
        expect(picture.lens.maker.name).not_to eq('undefined')
      end
    end
  end
end
