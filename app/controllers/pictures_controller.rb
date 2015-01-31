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
    if params[:path] && File.file?(params[:path])
      @picture = Picture.find_or_create_by(path: params[:path])
      render :show
    else
      render :new
    end
  end
end
