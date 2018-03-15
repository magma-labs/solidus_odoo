module Odoo
  class OrderLine
    attr_accessor :line_item, :product

    def self.create(line_item)
      order_line = self.new(line_item)
      order_line.save
    end

    def initialize(line_item)
      @line_item = line_item
    end

    def save
      SaleOrderLine.new(item_information)
    end

    def product
      @product ||= ProductProduct.find(default_code: line_item.product.slug).first
    end

    private
    def item_information
      {
        name: product.name,
        product_id: product.id,
        price_unit: line_item.total.to_s,
        product_uom_qty: line_item.quantity
      }
    end

  end
end
