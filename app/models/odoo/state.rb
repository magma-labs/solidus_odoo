module Odoo
  class State
    def self.find(address)
      state_name = address.state.name
      ResCountryState.find(name: state_name).first
    end
  end
end
