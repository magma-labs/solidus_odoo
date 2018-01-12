Spree::Order.state_machine.after_transition to: :complete do |order|
  OdooService.create_order(order)
end
