module Odoo
  class Partner

    attr_accessor :order, :state, :country, :odoo_partner

    def self.find_or_create(order)
      partner = self.new(order)
      odoo_partner = partner.retrieve
      partner.create unless odoo_partner
      partner.update if odoo_partner
      odoo_partner
    end

    def initialize(order)
      @order = order
      @odoo_partner = retrieve
    end

    def retrieve
      ResPartner.find(email: order.email).first
    end

    def update
      res_partner = odoo_partner
      res_partner.update(partner_attributes)
      res_partner.save
    end

    def create
      ResPartner.create(partner_attributes)
    end

    private
    def partner_attributes
      {
        name: order.name,
        street: order.ship_address.address1,
        city: order.ship_address.city,
        state_id: state.id,
        zip: order.ship_address.zipcode,
        country_id: country.id,
        phone: order.ship_address.phone,
        email: order.email,
        function: order.number #provisional while testing
      }
    end

    def state
      @state ||= State.find(order)
    end

    def country
      @country ||= Country.find(order)
    end

  end
end
