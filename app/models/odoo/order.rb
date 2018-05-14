module Odoo
  class Order
    attr_accessor :order, :partner, :order_lines

    def self.create(order)
      sale_order = self.new(order)
      sale_order.save
    end

    def initialize(order)
      @order = order
      @partner = partner
    end

    def save
      SaleOrder.create(partner_id: partner.odoo_partner.id,
                       order_line: order_lines,
                       name: order.number,
                       invoice_partner_id: partner.invoice_partner.id,
                       delivery_partner_id: partner.delivery_partner.id,
                       state: 'sale',
                       confirmation_date: DateTime.now.to_s(:db))
    end

    def partner
      @partner ||= Partner.find_or_create(order)
    end

    def order_lines
      @order_lines ||= order.line_items.map { |line_item| OrderLine.create(line_item) }
    end
  end
end

