require 'spec_helper'

describe Odoo::Country do
  let!(:order) { create(:order_with_line_items, state: 'complete') }

  context 'when an order is completed in solidus and Sale Order line is created in Odoo' do
    before(:each) do
      @address = order.ship_address.country.name
      @country = ResCountry.find(['name', '=', @address]).first.name
    end
    it 'should have a country' do
      expect('United States').to eq(@country)
    end
  end
end
