class PicturesController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def init
    render text: 'init'
  end

  def create
    if params[:path]
      jpeg = EXIFR::JPEG.new(params[:path])
      if jpeg.exif?
        @picture = Picture.new(
          path: params[:path],
          exposure_time: jpeg.exposure_time.to_s,
          f_number: jpeg.f_number.to_s,
          focal_length: jpeg.focal_length.to_s,
          iso: jpeg.iso_speed_ratings.to_s
        )
        @picture.save

        render text: 'created'
      else
        @picture = Picture.create(path: params[:path])
        render text: 'not created'
      end
    else
      render text: 'not created'
    end
  end
end
