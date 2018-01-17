class OdooService

  attr_accessor :order, :partner, :state, :country, :title, :odoo_order

  def self.create_order(order)
    self.new(order).create_odoo_order
  end

  def initialize(order)
    @order = order
  end

  def create_odoo_order
    @odoo_order ||= SaleOrder.create(partner_id: partner.id, order_line: order_lines)
  end

  def partner
    @partner ||= ResPartner.create(Partner.new(order, state, country, title).partner_information)
  end

  def state
    @state ||= ResCountryState.find(name: order.ship_address.state.name).first
  end

  def country
    @country ||= ResCountry.find(name: order.ship_address.country.name).first
  end

  def title
    @title ||= ResPartnerTitle.last
  end

  def order_lines
    @order_lines ||= order.line_items.map do |line_item|
      odoo_product = ProductProduct.create({
        name: line_item.name,
        list_price: line_item.price.to_f
      }) #this needs to be a find with something like line_item.product.odoo_id
      SaleOrderLine.new({
        name: odoo_product.name,
        product_id: odoo_product.id,
        price_unit: odoo_product.list_price,
        product_uom_qty: line_item.quantity
      })
    end
  end

end

