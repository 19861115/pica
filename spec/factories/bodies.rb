FactoryGirl.define do
  factory :body do
    sequence(:name) { |n| "body_#{n}" }
    maker
  end

end
