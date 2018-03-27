module Odoo
  class Country
    def self.find(order)
      country_name = order.ship_address.country.name
      ResCountry.find(name: country_name).first
    end
  end
end
