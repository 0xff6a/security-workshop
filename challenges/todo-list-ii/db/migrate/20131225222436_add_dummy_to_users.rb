class AddDummyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dummy, :boolean, default: false
  end
end
