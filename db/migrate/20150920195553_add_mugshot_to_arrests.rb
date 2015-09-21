class AddMugshotToArrests < ActiveRecord::Migration
  def change
    add_column :arrests, :mugshot, :string
  end
end
