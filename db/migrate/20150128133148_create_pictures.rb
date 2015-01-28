class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :path
      t.string :exposure_time
      t.string :f_number
      t.string :focal_length
      t.string :iso
      t.references :body, index: true
      t.references :lens_model, index: true

      t.timestamps
    end
  end
end
