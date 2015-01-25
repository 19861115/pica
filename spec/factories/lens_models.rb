FactoryGirl.define do
  factory :lens_model do
    sequence(:name) { |n| "lens_#{n}" }
    maker
  end

end
