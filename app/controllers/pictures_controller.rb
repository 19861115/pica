class PicturesController < ApplicationController
  def index
    @pictures = Picture.all
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
    @pictures = Picture.all
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
end
