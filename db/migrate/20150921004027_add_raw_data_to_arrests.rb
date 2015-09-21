class AddRawDataToArrests < ActiveRecord::Migration
  def change
    add_column :arrests, :raw_data, :text
  end
end
