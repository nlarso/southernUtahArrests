class Charge < ActiveRecord::Base
  belongs_to :arrest
  belongs_to :charge_type
end
