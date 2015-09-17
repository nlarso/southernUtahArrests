FactoryGirl.define do
  
  factory :charge do
    arrest
    charge_type
    name 'Trespassing'
    statute '1334.43(b)'
    classification '3F'
    required_bond 500
  end

end
