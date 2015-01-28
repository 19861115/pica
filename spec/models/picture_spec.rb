require 'rails_helper'

RSpec.describe Picture, :type => :model do
  before { @picture = FactoryGirl.create(:picture) }

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
end
