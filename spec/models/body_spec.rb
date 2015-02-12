require 'rails_helper'

RSpec.describe Body, type: :model do
  before { @body = FactoryGirl.build(:body) }

  subject { @body }

  specify { expect(subject).to respond_to(:name) }
  specify { expect(subject).to respond_to(:maker) }
  specify { expect(subject).to respond_to(:lenses) }

  describe '#name' do
    it 'can not be blank' do
      @body.name = ' '
      expect(subject).not_to be_valid
    end
  end

  describe '#new' do
    context 'without maker' do
      specify 'set default maker' do
        body = Body.new(name: 'test body')
        expect(body.name).to eq('test body')
        expect(body.maker.name).to eq('undefined')
      end
    end
  end
end
