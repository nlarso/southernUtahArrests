class Arrest < ActiveRecord::Base

  mount_uploader :mugshot, MugshotUploader

  has_many :charges, dependent: :destroy

  def self.upload_mugshots
    Arrest.where(mugshot: nil).each do |arrest|
      arrest.update_attribute(:remote_mugshot_url, arrest.external_mugshot_url)
    end
  end

end
