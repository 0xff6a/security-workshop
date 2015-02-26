class AddThingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :manager, :boolean
    add_column :users, :organisation_id, :integer
  end
end
