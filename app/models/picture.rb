class Picture < ActiveRecord::Base
  belongs_to :body
  belongs_to :lens_model
end
