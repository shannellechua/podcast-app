# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[7.2]
  def change
    # Create the users table with necessary fields for Devise
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      # Add other fields for Devise
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      # You can add other columns as needed:
      # t.string :name

      t.timestamps null: false
    end

    # Add indexes
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
