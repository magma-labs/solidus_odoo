class OdooService
  def self.create_order(order)
    Odoo::Order.create(order)
  end
end
