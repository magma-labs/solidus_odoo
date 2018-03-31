module Odoo
  class Country
    def self.find(address)
      country_name = address.country.name
      ResCountry.find(name: country_name).first
    end
  end
end
