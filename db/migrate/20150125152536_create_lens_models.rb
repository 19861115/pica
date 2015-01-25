class CreateLensModels < ActiveRecord::Migration
  def change
    create_table :lens_models do |t|
      t.string :name
      t.references :maker, index: true

      t.timestamps
    end
  end
end
