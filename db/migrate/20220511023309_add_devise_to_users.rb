# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
    end

    change_column_null :users, :email, false
    change_column_default :users, :email, from: nil, to: ""

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
