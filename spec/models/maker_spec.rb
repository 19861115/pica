require 'rails_helper'

RSpec.describe Maker, :type => :model do
  before { @maker = FactoryGirl.build(:maker) }

  subject { @maker }

  specify { expect(subject).to respond_to(:name) }
  specify { expect(subject).to respond_to(:bodies) }
  specify { expect(subject).to respond_to(:lenses) }
end
