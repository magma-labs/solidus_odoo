require 'spec_helper'

describe Odoo::Country do
  let!(:order) { create(:order_with_line_items, state: 'complete') }

  context 'when an order is completed in solidus and Sale Order line is created in Odoo' do
    it 'should have a state' do
      address = order.ship_address.state.name
      state = ResCountryState.find(['name', '=', address]).first.name

      expect('Alabama').to eq(state)
    end
  end
end
