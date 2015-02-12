FactoryGirl.define do
  factory :maker do
    sequence(:name) { |n| "maker_#{n}" }
  end
end
