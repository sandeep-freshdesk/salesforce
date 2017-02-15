class CreateAuthusers < ActiveRecord::Migration
  def change
    create_table :authusers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
