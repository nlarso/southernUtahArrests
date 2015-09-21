class AddLongitudeLatitudeAndZipCodeToArrests < ActiveRecord::Migration
  def change
    add_column :arrests, :longitude, :float
    add_column :arrests, :latitude, :float
    add_column :arrests, :zip_code, :string
  end
end
