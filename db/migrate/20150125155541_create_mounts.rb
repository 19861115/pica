class CreateMounts < ActiveRecord::Migration
  def change
    create_table :mounts do |t|
      t.references :body, index: true
      t.references :lens_model, index: true

      t.timestamps
    end
  end
end
