module Odoo
  class State
    def self.find(order)
      state_name = order.ship_address.state.name
      ResCountryState.find(name: state_name).first
    end
  end
end
