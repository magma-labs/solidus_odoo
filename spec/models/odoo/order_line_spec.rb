require 'spec_helper'

describe Odoo::OrderLine do
  let(:order) { create(:order_with_line_items, state: 'complete') }

  context 'When a spree order is sent to odoo' do
    it 'should throw "name" error if product does not exist in odoo' do
      line_item = order.products.last
      expect(ProductProduct.find(default_code: line_item.slug)).to be_blank
    end

    it 'should find product in odoo' do
      expect(ProductProduct.find(default_code: 'product-3-935')).to be_truthy
    end
  end
end
