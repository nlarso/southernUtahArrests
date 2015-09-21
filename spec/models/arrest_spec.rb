require 'rails_helper'

describe Arrest do
  it 'has a valid factory' do
    expect(build(:arrest)).to be_valid
  end

  describe '#geocode' do
    let(:arrest) do
      build(:arrest, {
        address: '1215 Main Street',
        city: 'St. George',
        state: 'UT',
        latitude: nil,
        longitude: nil,
        zip_code: nil
      })
    end

    before do
      arrest.valid?
    end

    it 'sets the latitude' do
      expect(arrest.latitude).to_not be(nil)
    end

    it 'sets the longitude' do
      expect(arrest.longitude).to_not be(nil)
    end

    it 'sets the zip_code' do
      expect(arrest.zip_code).to_not be(nil)
    end
  end

  describe '#needs_geocoding?' do
    let(:arrest) do
      build(:arrest, city: 'St. George', state: 'UT', latitude: nil, longitude: nil)
    end

    it 'is true' do
      expect(arrest.needs_geocoding?).to be true
    end

    it 'is false when city is blank' do
      arrest.city = nil
      expect(arrest.needs_geocoding?).to be false
    end

    it 'is false when state is blank' do
      arrest.state = nil
      expect(arrest.needs_geocoding?).to be false
    end

    it 'is false when latitude is present' do
      arrest.latitude = 37.087454
      expect(arrest.needs_geocoding?).to be false
    end

    it 'is false when longitude is present' do
      arrest.longitude = -113.583087
      expect(arrest.needs_geocoding?).to be false
    end
  end

  describe '#full_address' do
    let(:arrest) do
      build(:arrest, address: '1215 Main Street', city: 'St. George', state: 'UT')
    end

    it 'returns the full address' do
      expect(arrest.full_address).to eq('1215 Main Street, St. George, UT')
    end

    it 'returns nil if the city is blank' do
      arrest.city = nil
      expect(arrest.full_address).to be nil
    end

    it 'returns nil if the state is blank' do
      arrest.state = nil
      expect(arrest.full_address).to be nil
    end
  end
end
