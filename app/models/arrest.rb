class Arrest < ActiveRecord::Base

  mount_uploader :mugshot, MugshotUploader

  has_many :charges, dependent: :destroy

  geocoded_by :full_address do |obj, results|
    if result = results.first
      obj.city = result.city
      obj.latitude = result.latitude
      obj.longitude = result.longitude
      obj.state = result.state_code
      obj.zip_code = result.postal_code
    end
  end

  after_validation :geocode, if: :needs_geocoding?

  def self.upload_mugshots
    Arrest.where(mugshot: nil).each do |arrest|
      arrest.update_attribute(:remote_mugshot_url, arrest.external_mugshot_url)
    end
  end

  def needs_geocoding?
    return false if latitude.present? || longitude.present?
    return false if city.blank? || state.blank?
    true
  end

  def full_address
    if city.blank? || state.blank?
      nil
    else
      [address, city, state, zip_code].compact.join(', ')
    end
  end

end
