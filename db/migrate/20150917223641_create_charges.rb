class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.references :arrest, index: true, foreign_key: true
      t.references :charge_type, index: true, foreign_key: true
      t.string :name
      t.string :statute
      t.string :classification
      t.integer :required_bond

      t.timestamps null: false
    end
  end
end
