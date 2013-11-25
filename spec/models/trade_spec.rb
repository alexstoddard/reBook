require 'spec_helper'

describe Trade do
  it "each user should be in one trade line for own and one trade line for need" do
    owns = {}
    needs = {}

    @trade = Trade.find(1)
    
    @trade.trade_lines.each do |line|
      owns[line.inventory_own.user_id] += 1
      needs[line.inventory_need.user_id] += 1
    end
   
    
  end
end
