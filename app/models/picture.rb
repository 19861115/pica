class Picture < ActiveRecord::Base
  belongs_to :body
  belongs_to :lens_model
  alias_attribute :lens, :lens_model

  validates :path, presence: true

  def initialize(attributes = {}, options = {})
    super
    if path && FileTest.file?(path)
      jpeg = EXIFR::JPEG.new(path)
      if jpeg.exif?
        init_by_exif_attributes(jpeg)
      else
        init_by_default_attributes
      end
    else
      init_by_default_attributes
    end
  end

  private

  def get_body_id(model, make)
    Body.find_or_create_by(
      name:
      model ? model.to_s : 'undefined',
      maker_id:
      Maker.find_or_create_by(name: make ? make.to_s : 'undefined').id
    ).id
  end

  def get_lens_id(lens_model, lens_make)
    LensModel.find_or_create_by(
      name:
      lens_model ? lens_model.to_s : 'undefined',
      maker_id:
      Maker.find_or_create_by(name: lens_make ? lens_make.to_s : 'undefined').id
    ).id
  end

  def init_by_exif_attributes(jpeg)
    body_id = get_body_id(jpeg.model, jpeg.make)
    lens_id = get_lens_id(jpeg.lens_model, jpeg.lens_make)
    self.attributes = {
      exposure_time:
      jpeg.exposure_time ? jpeg.exposure_time.to_s : 'undefined',
      f_number:
      jpeg.f_number ? jpeg.f_number.to_f.to_s : 'undefined',
      focal_length:
      jpeg.focal_length ? jpeg.focal_length.to_s : 'undefined',
      iso:
      jpeg.iso_speed_ratings ? jpeg.iso_speed_ratings.to_s : 'undefined',
      body_id:
      body_id,
      lens_model_id:
      lens_id
    }
    Mount.find_or_create_by(body_id: body_id, lens_model_id: lens_id)
  end

  def init_by_default_attributes
    self.attributes = {
      exposure_time: 'undefined',
      f_number: 'undefined',
      focal_length: 'undefined',
      iso: 'undefined',
      body_id: Body.find_or_create_by(name: 'undefined').id,
      lens_model_id: LensModel.find_or_create_by(name: 'undefined').id
    }
  end
end
