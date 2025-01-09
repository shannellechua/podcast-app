class AddUserIdToDummies < ActiveRecord::Migration[7.2]
  def change
    add_reference :dummies, :user, null: false, foreign_key: true
  end
end
