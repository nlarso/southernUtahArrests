class ChargeType < ActiveRecord::Base
  has_many :charges, dependent: :destroy
end
