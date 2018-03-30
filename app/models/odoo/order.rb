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
      SaleOrder.create(partner_id: partner.id,
                       order_line: order_lines,
                       name: order.number)
    end

    def partner
      @partner ||= Partner.find_or_create(order)
    end

    def order_lines
      @order_lines ||= order.line_items.map { |line_item| OrderLine.create(line_item) }
    end
  end
end
