require 'rails_helper'

RSpec.describe LensModel, :type => :model do
  before { @lens = FactoryGirl.create(:lens_model) }

  subject { @lens }

  specify { expect(subject).to respond_to(:name) }
  specify { expect(subject).to respond_to(:maker) }
  specify { expect(subject).to respond_to(:bodies) }

  describe '#name' do
    it 'can not be blank' do
      @lens.name = ' '
      expect(subject).not_to be_valid
    end
  end
end
