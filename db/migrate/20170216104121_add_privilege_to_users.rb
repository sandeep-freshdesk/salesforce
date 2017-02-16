class AddPrivilegeToUsers < ActiveRecord::Migration
  def self.up
  	add_column :users, :privilege, :boolean, :default => false 
  end

  def self.down
  	remove_column :users, :privilege
  end
end
