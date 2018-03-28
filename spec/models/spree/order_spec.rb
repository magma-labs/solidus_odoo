require 'spec_helper'

describe Spree::Order do
  let!(:order) { create(:order_with_line_items, state: 'complete') }

  context 'An order should be created' do
    it 'should be generated' do
      expect(Spree::Order.count).to be(1)
    end

    it 'should have status as completed' do
      expect("complete").to eq(order.state)
    end
  end
end
