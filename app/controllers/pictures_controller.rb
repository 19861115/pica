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
      @picture = Picture.create(path: params[:path])
      render text: 'created'
    else
      render text: 'not created'
    end
  end
end
