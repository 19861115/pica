require 'rails_helper'

RSpec.describe Mount, type: :model do
  before { @mount = FactoryGirl.create(:mount) }

  subject { @mount }

  specify { expect(subject).to respond_to(:body) }
  specify { expect(subject).to respond_to(:lens) }
end
