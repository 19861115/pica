class Maker < ActiveRecord::Base
  has_many :bodies
  has_many :lens_models
  alias_attribute :lenses, :lens_models

  validates :name, presence: true
end
