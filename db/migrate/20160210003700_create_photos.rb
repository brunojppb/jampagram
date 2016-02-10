class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title, null: false, default: ''
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
