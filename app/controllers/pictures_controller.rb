class PicturesController < ApplicationController
  def index
    @pictures = Picture.includes(
      :body, :lens_model
    ).all.order(:path).page(params[:page]).per(100)
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
    @pictures = Picture.includes(
      :body, :lens_model
    ).all.order(:path).page(params[:page]).per(100)
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
    return if Picture.count == 0
    @pictures = Picture.includes(:body, :lens_model).all
    @exposure_times = exposure_times(@pictures)
    @f_numbers = f_numbers(@pictures)
    @focal_lengthes = focal_lengthes(@pictures)
    @isoes = isoes(@pictures)
    @bodies = bodies(@pictures)
    @lenses = lenses(@pictures)
  end

  private

  def to_f(val)
    if val.include?('/')
      splitted = val.split('/')
      Rational(splitted[0], splitted[1]).to_f
    else
      0.0
    end
  end

  def exposure_times(pictures)
    exposure_times = {}
    pictures.pluck(:exposure_time).uniq.each do |e|
      exposure_times[e] = Picture.where(exposure_time: e).count
    end
    exposure_times.sort_by { |key, _val| to_f(key) }
  end

  def f_numbers(pictures)
    f_numbers = {}
    pictures.pluck(:f_number).uniq.each do |f|
      f_numbers[f] = Picture.where(f_number: f).count
    end
    f_numbers.sort_by { |key, _val| key }
  end

  def focal_lengthes(pictures)
    focal_lengthes = {}
    pictures.pluck(:focal_length).uniq.each do |f|
      focal_lengthes[to_f(f)] = Picture.where(focal_length: f).count
    end
    focal_lengthes.sort_by { |key, _val| key }
  end

  def isoes(pictures)
    isoes = {}
    pictures.pluck(:iso).uniq.each do |i|
      isoes[i] = Picture.where(iso: i).count
    end
    isoes.sort_by { |key, _val| key }
  end

  def bodies(pictures)
    bodies = {}
    pictures.pluck(:body_id).uniq.each do |b|
      body_name = Body.find_by(id: b).name
      bodies[body_name] = Picture.where(body_id: b).count
    end
    bodies.sort_by { |key, _val| key }
  end

  def lenses(pictures)
    lenses = {}
    pictures.pluck(:lens_model_id).uniq.each do |l|
      lens_name = LensModel.find_by(id: l).name
      lenses[lens_name] = Picture.where(lens_model_id: l).count
    end
    lenses.sort_by { |key, _val| key }
  end
end
