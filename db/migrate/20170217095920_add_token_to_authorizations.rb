class AddTokenToAuthorizations < ActiveRecord::Migration
  def self.up
    add_column :authorizations, :refresh_token, :string
  end

  def self.down
  	remove_column :authorizations, :refresh_token
  end
end
