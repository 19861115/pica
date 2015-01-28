class Body < ActiveRecord::Base
  belongs_to :maker
  has_many :mounts
  has_many :lens_models, through: :mounts
  alias_attribute :lenses, :lens_models

  validates :name, presence: true
end
