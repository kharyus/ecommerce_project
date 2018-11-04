class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.decimal :price
      t.references :category, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
