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
          iso: jpeg.iso_speed_ratings.to_s,
          body_id: get_body_id(jpeg.model, jpeg.make),
          lens_model_id: get_lens_id(jpeg.lens_model, jpeg.lens_make)
        }
      end
    end
  end

  private

  def get_body_id(model, make)
    if make
      maker = Maker.find_or_create_by(name: make.to_s)
      Body.find_or_create_by(name: model.to_s, maker_id: maker.id).id if model
    end 
  end

  def get_lens_id(lens_model, lens_make)
    if lens_make
      maker = Maker.find_or_create_by(name: lens_make.to_s)
      LensModel.find_or_create_by(name: lens_model.to_s, maker_id: maker.id).id if lens_model
    end 
  end
end
