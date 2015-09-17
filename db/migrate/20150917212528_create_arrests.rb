class CreateArrests < ActiveRecord::Migration
  def change
    create_table :arrests do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :pcf_number
      t.string :arrested_by
      t.string :agency
      t.datetime :arrested_at

      t.timestamps null: false
    end
  end
end
