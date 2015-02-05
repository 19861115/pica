class PicturesController < ApplicationController
  def index
    @pictures = Picture.includes(:body, :lens_model).all.order(:path).page(params[:page]).per(100)
  end

  def new
  end

  def show
  end

  def init
    if params[:path]
      Dir.glob(params[:path] + '**/*.{JPG,JPEG,jpg,jpeg}').each do |p|
        Picture.find_or_create_by(path: p) if File.file?(p)
      end
    end
    @pictures = Picture.includes(:body, :lens_model).all.order(:path).page(params[:page]).per(100)
    render :index
  end

  def create
    if params[:path] && File.file?(params[:path])
      @picture = Picture.find_or_create_by(path: params[:path])
      render :show
    else
      render :new
    end
  end

  def charts
    if Picture.count > 0
      @pictures = Picture.includes(:body, :lens_model).all
      # generate exposure_times hash
      exposure_times = {}
      @pictures.pluck(:exposure_time).uniq.each do |e|
        exposure_times[e] = Picture.where(exposure_time: e).count
      end
      @exposure_times_sorted = exposure_times.sort_by { |key, val| to_f(key) }

      # generate f_numbers hash
      f_numbers = {}
      @pictures.pluck(:f_number).uniq.each do |f|
        f_numbers[f] = Picture.where(f_number: f).count
      end
      @f_numbers_sorted = f_numbers.sort_by { |key, val| key }

      # generate focal_lengths hash
      focal_lengthes = {}
      @pictures.pluck(:focal_length).uniq.each do |f|
        focal_lengthes[to_f(f)] = Picture.where(focal_length: f).count
      end
      @focal_lengthes_sorted = focal_lengthes.sort_by { |key, val| key }

      # generate isoes hash
      isoes = {}
      @pictures.pluck(:iso).uniq.each do |i|
        isoes[i] = Picture.where(iso: i).count
      end
      @isoes_sorted = isoes.sort_by { |key, val| key }

      # generate bodies hash
      bodies = {}
      @pictures.pluck(:body_id).uniq.each do |b|
        bodies[Body.find_by(id: b).name] = Picture.where(body_id: b).count
      end
      @bodies_sorted = bodies.sort_by { |key, val| key }

      # generate lenses hash
      lenses = {}
      @pictures.pluck(:lens_model_id).uniq.each do |l|
        lenses[LensModel.find_by(id: l).name] = Picture.where(lens_model_id: l).count
      end
      @lenses_sorted = lenses.sort_by { |key, val| key }
    end
  end

  private

  def to_f(val)
    unless val == "undefined"
      splitted = val.split('/')
      Rational(splitted[0], splitted[1]).to_f
    else
      0.0
    end
  end
end
