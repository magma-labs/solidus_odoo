require 'spec_helper'

describe Spree::Order do
  let!(:order) { create(:order_with_line_items) }

  context 'An order should be created' do
    it 'should be generated' do
      binding.pry
      expect(Spree::Order.count).to be(1)
    end
  end
end
