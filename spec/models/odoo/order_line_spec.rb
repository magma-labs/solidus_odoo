require 'spec_helper'

describe Odoo::OrderLine do
  let!(:shipping_option) { create(:shipping_method, cost: 0) }
  let(:order) { create(:order_with_line_items, state: 'complete', line_items: [create(:line_item, product: product)]) }
  let(:product) { create(:product, shipping_category: shipping_category) }
  let(:shipping_category) { create(:shipping_category, shipping_methods: [shipping_method]) }
  let(:shipping_method) { create(:shipping_method) }

  context 'When a spree order is sent to odoo' do
    before :each do
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
  end

end
