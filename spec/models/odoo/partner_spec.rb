require 'spec_helper'

describe Odoo::Partner do
  let!(:order) { create(:order_with_line_items, state: 'complete') }

  context 'when user completes an order' do
    it 'should not have an account in odoo' do
      expect(nil).to be(ResPartner.find(email: order.email).first)
    end

    it 'should create an account in odoo' do
      address = order.ship_address
      ResPartner.create(name: order.name,
                        street: address.address1,
                        city: address.city,
                        state_id: address.state.id,
                        zip: address.zipcode,
                        country_id: address.country.id,
                        phone: address.phone,
                        email: order.email)

      expect(ResPartner.find(email: order.email)).to be_truthy
    end

    it 'should have an account in odoo' do
      order.email = 'test@example.com'
      expect(ResPartner.find(email: order.email)).to be_truthy
    end

    it 'should have an account with billing/shipping address' do
      address = order.ship_address

      def partner_attributes(address)
        {
          name: order.name,
          street: address.address1,
          city: address.city,
          state_id: address.id,
          zip: address.zipcode,
          country_id: address.id,
          phone: address.phone,
          email: order.email
        }
      end

      @odoo_partner = ResPartner.create partner_attributes(address)
      @invoice_partner = ResPartner.create partner_attributes(order.bill_address).merge(name: "billing", type: "invoice", parent_id: @odoo_partner.id)
      @delivery_partner = ResPartner.create partner_attributes(order.ship_address).merge(name: "shipping", type: "delivery", parent_id: @odoo_partner.id)
      @odoo_partner.save

      expect(@odoo_partner.associations['child_ids']).not_to be_blank
    end
  end
end
