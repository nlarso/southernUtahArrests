require 'rails_helper'

describe Charge do
  it 'has a valid factory' do
    expect(build(:charge)).to be_valid
  end
end
