FactoryGirl.define do
  factory :picture do
    sequence(:path) { |n| "path_#{n}" }
    sequence(:exposure_time) { |n| "exposure_time_#{n}" }
    sequence(:f_number) { |n| "f_number_#{n}" }
    sequence(:focal_length) { |n| "focal_length_#{n}" }
    sequence(:iso) { |n| "iso_#{n}" }
    body
    lens_model
  end

end
