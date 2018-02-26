require 'rails_helper'

describe Spree::Order, type: :model do

  context '#state_changes_to_complete' do
    it should 'return state completed' do

      expect (Spree::Order.state_machine)to eq(:completed)
    end
  end

end
