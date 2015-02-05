class Picture < ActiveRecord::Base
  belongs_to :body
  belongs_to :lens_model
  alias_attribute :lens, :lens_model

  validates :path, presence: true

  def initialize(attributes = {}, options = {})
    super
    if self.path && FileTest.file?(self.path)
      jpeg = EXIFR::JPEG.new(self.path)
      if jpeg.exif?
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
      else
        self.attributes = {
          exposure_time: 'undefined',
          f_number: 'undefined',
          focal_length: 'undefined',
          iso: 'undefined',
          body_id: Body.find_or_create_by(name: 'undefined').id,
          lens_model_id: LensModel.find_or_create_by(name: 'undefined').id
        }
      end
    else
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

  private

  def get_body_id(model, make)
    if model && make
      maker = Maker.find_or_create_by(name: make.to_s)
      Body.find_or_create_by(name: model.to_s, maker_id: maker.id).id
    elsif model && !make
      maker = Maker.find_or_create_by(name: 'undefined')
      Body.find_or_create_by(name: model.to_s, maker_id: maker.id).id
    elsif !model && make
      maker = Maker.find_or_create_by(name: make.to_s)
      Body.find_or_create_by(name: 'undefined', maker_id: maker.id).id
    else
      Body.find_or_create_by(name: 'undefined').id
    end
  end

  def get_lens_id(lens_model, lens_make)
    if lens_model && lens_make
      maker = Maker.find_or_create_by(name: lens_make.to_s)
      LensModel.find_or_create_by(name: lens_model.to_s, maker_id: maker.id).id
    elsif lens_model && !lens_make
      maker = Maker.find_or_create_by(name: 'undefined')
      LensModel.find_or_create_by(name: lens_model.to_s, maker_id: maker.id).id
    elsif !lens_model && lens_make
      maker = Maker.find_or_create_by(name: lens_make.to_s)
      LensModel.find_or_create_by(name: 'undefined', maker_id: maker.id).id
    else
      LensModel.find_or_create_by(name: 'undefined').id
    end
  end
end
