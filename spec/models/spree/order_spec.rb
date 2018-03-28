require 'spec_helper'

describe Spree::Order do
  let!(:store) { create(:store) }

  context 'x' do
    it 'y' do
      expect(Spree::Order.count).to be(1)
    end
  end
end
