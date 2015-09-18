class AddExternalMugshotUrlToArrests < ActiveRecord::Migration
  def change
    add_column :arrests, :external_mugshot_url, :string
  end
end
