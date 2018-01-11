Spree::Order.state_machine.after_transition to: :address do |order|
  OdooService.create_order(order)
end
