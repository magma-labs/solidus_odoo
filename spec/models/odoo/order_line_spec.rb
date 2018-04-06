require 'spec_helper'

describe Odoo::OrderLine do
  let!(:shipping_option) { create(:shipping_method, cost: 0) }
  let(:order) { create(:order_with_line_items, state: 'complete', line_items: [create(:line_item, product: product)]) }
  let(:product) { create(:product, shipping_category: shipping_category) }
  let(:shipping_category) { create(:shipping_category, shipping_methods: [shipping_method]) }
  let(:shipping_method) { create(:shipping_method) }

  context 'When a spree order is sent to odoo' do
    before :each do
      binding.pry
      calculator = product.shipping_category.shipping_methods.first.calculator
      calculator.preferred_amount = "0.0"
      calculator.save
    end
    it 'should throw "name" error if product does not exist in odoo' do
      line_item = order.products.last
      expect(ProductProduct.find(default_code: line_item.slug)).to be_blank
    end

    it 'should find product in odoo' do
      expect(ProductProduct.find(default_code: 'product-3-935')).to be_truthy
    end

    it 'should complete an order' do
      binding.pry
      product = order.products.last
      product.name = "Samsung Tv"
      product.save!
      product.slug = "samsung-tv"
      product.save!
      product.reload
      order.reload
      OdooService.create_order(order)
      odoo_order = SaleOrder.find(['name', '=', order.number])
    end
  end
end
