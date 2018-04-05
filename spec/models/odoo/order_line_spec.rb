require 'spec_helper'

describe Odoo::OrderLine do
  let!(:order) { create(:order_with_line_items, state: 'complete') }
  let!(:product) { create(:base_product, name: 'Samsung Tv', slug: 'samsung-tv') }

  context 'When a spree order is sent to odoo' do
    it 'should throw "name" error if product does not exist in odoo' do
      line_item = order.products.last
      expect(ProductProduct.find(default_code: line_item.slug)).to be_blank
    end

    it 'should find product in odoo' do
      expect(ProductProduct.find(default_code: product.slug)).to be_truthy
    end

    it 'should complete an order' do
      product = order.products.last
      product.name = "Samsung Tv"
      product.slug = "samsung-tv"
      product.save!
      product.reload
      order.reload
    end
  end
end
