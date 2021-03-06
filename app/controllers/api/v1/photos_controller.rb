class Api::V1::PhotosController < ApplicationController

  before_action :authenticate_api_user!, only: [:create]
  before_action :decode_image_upload, only: [:create]

  def index
    render json: Photo.order(created_at: :desc), status: 200
  end

  def create
    photo = current_api_user.photos.build(photo_params)
    if photo.save
      render json: photo, status: :created
    else
      render json: { errors: photo.errors }, status: :unprocessable_entity
    end
  end

  private
    def photo_params
      params.require(:data).require(:attributes).permit(:title, :image_file)
    end

    def decode_image_upload
      if params[:data][:attributes][:image_file]
        base64_image = params[:data][:attributes][:image_file][:file]
        extension = params[:data][:attributes][:image_file][:extension]
        content_type = params[:data][:attributes][:image_file][:content_type]
        data = StringIO.new(Base64.decode64(base64_image))

        # assign some attributes for carrierwave processing
        data.class.class_eval { attr_accessor :original_filename, :content_type }

        data.original_filename = "#{Time.now}.#{extension}"
        data.content_type = "#{content_type}"

        params[:data][:attributes][:image_file] = data
      end
    end

end
