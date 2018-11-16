class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_hash
      t.string :name
      t.string :address
      t.references :province, foreign_key: true

      t.timestamps
    end
  end
end
