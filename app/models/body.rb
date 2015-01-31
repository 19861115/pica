class Body < ActiveRecord::Base
  belongs_to :maker
  has_many :mounts
  has_many :lens_models, through: :mounts
  alias_attribute :lenses, :lens_models

  validates :name, presence: true

  def initialize(attributes = {}, options = {})
    super
    unless self.maker_id
      self.attributes = { maker_id: Maker.find_or_create_by(name: 'undefined').id }
    end
  end
end
