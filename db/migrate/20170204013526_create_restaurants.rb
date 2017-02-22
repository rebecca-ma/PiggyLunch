class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :description
      t.text :tags
      t.string :map_url
      t.timestamps
    end
  end
end
