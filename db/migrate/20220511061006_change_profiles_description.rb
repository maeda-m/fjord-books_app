class ChangeProfilesDescription < ActiveRecord::Migration[6.1]
  def up
    change_table :profiles do |t|
      t.change :description, :text
    end
  end

  def down
    change_table :profiles do |t|
      t.change :description, :string
    end
  end
end
