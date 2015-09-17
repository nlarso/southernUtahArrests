require 'rails_helper'

describe Arrest do
  it 'has a valid factory' do
    expect(build(:arrest)).to be_valid
  end
end
