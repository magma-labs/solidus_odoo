require 'spec_helper'

describe Odoo::OrderLine do
  let!(:order) { create(:order_with_line_items, state: 'complete') }
  let!(:product) { create(:base_product, name: 'Samsung Tv', slug: 'samsung-tv') }

  context 'When a spree order is sent to odoo' do
    it 'should throw "name" error if product does not exist in odoo' do
      line_item = order.products.last
      expect(ProductProduct.find(default_code: line_item.slug)).to be_blank
    end
  end
end
