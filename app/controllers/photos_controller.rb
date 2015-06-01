class PhotosController < ApplicationController
  # before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # respond_to :html

  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
  end

  # def new
  #   @photo = Photo.new
  #   respond_with(@photo)
  # end

  def edit
  end

  def create
    @photo = Photo.new(params[:photo])
    @photo.image = File.new(upload_path)
    @photo.save

    redirect_to @photo
  end

  # def update
  #   @photo.update(photo_params)
  #   respond_with(@photo)
  # end

  # def destroy
  #   @photo.destroy
  #   respond_with(@photo)
  # end

  def upload
    @photo = Photo.new(params[:photo])
    # File.open(upload_path, 'wb') do |f|
    #   f.write request.raw_post
    # end
    @photo.set_picture(request.raw_post)
    @photo.save!
    render :text => "Foto OK"
  end

  private

  def upload_path # is used in upload and create
    File.join(Rails.root, 'tmp', 'photo.jpg')
  end

  # def set_photo
  #   @photo = Photo.find(params[:id])
  # end

  # def photo_params
  #   params.require(:photo).permit(:descricao)
  # end
end
