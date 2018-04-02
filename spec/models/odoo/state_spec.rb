require 'spec_helper'

describe Odoo::Country do
  let!(:order) { create(:order_with_line_items, state: 'complete') }
  Ooor.new(url: 'https://magmalabs1.odoo.com', database: 'magmalabs1', username: 'alberto.mendoza@magmalabs.io', password: 'Please123')

  context 'when an order is completed in solidus and Sale Order line is created in Odoo' do

    it 'should have a state' do
      address = order.ship_address
      state_name = address.state.name
      expect(ResCountryState.find(name: state_name).first).to be_truthy
    end
  end
end
