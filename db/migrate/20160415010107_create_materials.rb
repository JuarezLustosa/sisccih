class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :description, null: false, unique: true

      t.timestamps null: false
    end
  end
end
