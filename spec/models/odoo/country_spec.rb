require 'spec_helper'

describe Odoo::Country do
  let!(:order) { create(:order_with_line_items, state: 'complete') }

  context 'when an order is completed in solidus and Sale Order line is created in Odoo' do
    it 'should have a country' do
      address = order.ship_address.country.name
      country = ResCountry.find(['name', '=', address]).first.name

      expect('United States').to eq(country)
    end
  end
end
