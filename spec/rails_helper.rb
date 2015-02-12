ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  # FactiryGirl
  config.before :all do
    FactoryGirl.reload
  end
end

def dummy_picture_path(filename)
  Rails.root.join('spec/dummy_pictures/' + filename).to_s
end
