require 'rails_helper'

RSpec.describe Munchies do
  it 'exists' do
    attr = File.read('spec/fixtures/munchies.json')
    attr_json = JSON.parse(attr, symbolize_names: true)
    munchies = Munchies.new(attr_json)
    expect(munchies).to be_a(Munchies)
    expect(munchies.id).to eq(nil)
    expect(munchies.name).to eq('Odyssey Italian Restaurant') 
    expect(munchies.reviews).to eq(1313)
    expect(munchies.rating).to eq(4.5)
    expect(munchies.address).to eq('603 E 6th Ave, Denver, CO 80203')
  end
end