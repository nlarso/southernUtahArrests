class Arrest < ActiveRecord::Base
  has_many :charges, dependent: :destroy
end
