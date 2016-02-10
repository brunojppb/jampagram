class AddImageFileToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :image_file, :string, null: false, default: ''
  end
end
