module Odoo
  class Partner
    attr_accessor :order, :odoo_partner, :invoice_partner, :delivery_partner

    def self.find_or_create(order)
      partner = self.new(order)
      partner.create unless partner.odoo_partner
      partner.create_children
      partner
    end

    def initialize(order)
      @order = order
      @odoo_partner = retrieve
    end

    def retrieve
      ResPartner.find(email: order.email).first
    end

    def create
      @odoo_partner = ResPartner.create partner_attributes(order.ship_address)
    end

    def create_children
      @invoice_partner = ResPartner.create partner_attributes(order.bill_address).merge(name: "billing", type: "invoice", parent_id: odoo_partner.id)
      @delivery_partner = ResPartner.create partner_attributes(order.ship_address).merge(name: "shipping", type: "delivery", parent_id: odoo_partner.id)
    end

    private

    def partner_attributes(address)
      {
        name: order.name,
        street: address.address1,
        city: address.city,
        state_id: state(address).id,
        zip: address.zipcode,
        country_id: country(address).id,
        phone: address.phone,
        email: order.email
      }
    end

    def state(address)
      State.find(address)
    end

    def country(address)
      Country.find(address)
    end
  end
end
