class CreateDummies < ActiveRecord::Migration[7.2]
  def change
    create_table :dummies do |t|
      t.string :spotify_id
      t.string :name
      t.string :show

      t.timestamps
    end
  end
end
