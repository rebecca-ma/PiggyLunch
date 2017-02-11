class CreatePiggies < ActiveRecord::Migration[5.0]
  def change
    create_table :piggies do |t|
      t.belongs_to :user, index: true
      t.belongs_to :restaurant, index: true
      t.integer :piggy_score
      t.text :comment
      t.timestamps
    end
  end
end
