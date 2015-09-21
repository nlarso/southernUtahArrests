class Arrest < ActiveRecord::Base

  mount_uploader :mugshot, MugshotUploader

  has_many :charges, dependent: :destroy

end
