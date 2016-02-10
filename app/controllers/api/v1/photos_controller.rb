class Api::V1::PhotosController < ApplicationController

  before_action :authenticate_api_user!, only: [:index, :create, :destroy]

  def index
    render json: current_api_user.photos, status: 200
  end

  def create
    photo = current_api_user.photos.build(photo_params)
    if photo.save
      render json: photo, status: 202
    else
      render json: { errors: photo.errors }, status: :unprocessable_entity
    end
  end

  def destoy
    photo = current_api_user.photos.find(params[:id])
    if photo && photo.destroy
      head 204
    else
      render json: { errors: 'photo not found' }, status: :unprocessable_entity
    end
  end

  private
    def photo_params
      params.require(:data).require(:attributes).permit(:title)
    end

end
