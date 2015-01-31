class Picture < ActiveRecord::Base
  belongs_to :body
  belongs_to :lens_model
  alias_attribute :lens, :lens_model

  validates :path, presence: true

  def initialize(attributes = {}, options = {})
    super
    if self.path
      jpeg = EXIFR::JPEG.new(self.path)
      if jpeg.exif?
        self.attributes = {
          exposure_time: jpeg.exposure_time.to_s,
          f_number: jpeg.f_number.to_f.to_s,
          focal_length: jpeg.focal_length.to_s,
          iso: jpeg.iso_speed_ratings.to_s
        }
      end
    end
  end
end
