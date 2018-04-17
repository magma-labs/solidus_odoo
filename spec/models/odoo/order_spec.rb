require 'spec_helper'

describe Odoo::Order do
  let(:order) { create(:order_with_line_items, state: 'complete') }

  context 'When a spree order is sent to odoo' do
    before(:each) do
      @product = order.products.last
      @product.name = "Samsung Tv"
      @product.save!
      @product.slug = "samsung-tv"
      @product.save!
      @product.reload
      order.reload
    end

    it 'should have total sale price in odoo as in solidus' do
      OdooService.create_order(order)

      expect(SaleOrder.last.amount_total).to eq(order.total - order.ship_total)
    end
  end
end
