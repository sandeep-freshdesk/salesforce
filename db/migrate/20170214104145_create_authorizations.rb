class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :authuid
      t.integer :authuser_id

      t.timestamps
    end
  end
end
