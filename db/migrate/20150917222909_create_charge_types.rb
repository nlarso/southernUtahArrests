class CreateChargeTypes < ActiveRecord::Migration
  def change
    create_table :charge_types do |t|
      t.string :name
      t.string :statute
      t.string :classification

      t.timestamps null: false
    end
  end
end
