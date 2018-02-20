Spree::Order.class_eval do
  def create_odoo_order
    OdooService.create_order(self)
  end
end

Spree::Order.state_machine.after_transition to: :complete, do: :create_odoo_order
