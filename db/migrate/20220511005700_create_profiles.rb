class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :zipcode
      t.string :address
      t.string :description

      t.timestamps
    end
  end
end
