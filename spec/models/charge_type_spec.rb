require 'rails_helper'

describe ChargeType do
  it 'has a valid factory' do
    expect(build(:charge_type)).to be_valid
  end
end
