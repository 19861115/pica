class LensModel < ActiveRecord::Base
  belongs_to :maker
  has_many :mounts
  has_many :bodies, through: :mounts

  validates :name, presence: true
end
