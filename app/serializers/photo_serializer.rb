class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :title, :image_url

  def image_url
    object.image_file.url
  end

end
