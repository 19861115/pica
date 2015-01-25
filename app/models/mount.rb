class Mount < ActiveRecord::Base
  belongs_to :body
  belongs_to :lens_model
  alias_attribute :lens, :lens_model
end
