class LensModel < ActiveRecord::Base
  belongs_to :maker
  has_many :mounts
  has_many :bodies, through: :mounts

  validates :name, presence: true

  def initialize(attributes = {}, options = {})
    super
    unless maker_id
      self.attributes = {
        maker_id: Maker.find_or_create_by(name: 'undefined').id
      }
    end
  end
end
