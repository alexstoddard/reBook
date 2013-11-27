require 'spec_helper'

describe Trade do

  describe "Possible Trades" do
    before :each do

      @trades = []

      User.all.collect { |x| x.id }.each do |y|
        @trades += Trade.possible_trades(y)
      end

    end

    it "each user should be in one trade line for own and one trade line for need in possible trades" do

      # For each trade count the number of times each user is in a hava and in a need
      @trades.each do |trade|
        owns = {}
        needs = {}
        
        trade.trade_lines.each do |line|
          if owns[line.inventory_own.user_id].nil?
            owns[line.inventory_own.user_id] = 1
          else
            owns[line.inventory_own.user_id] += 1
          end

          if needs[line.inventory_need.user_id].nil?
            needs[line.inventory_need.user_id] = 1
          else
            needs[line.inventory_need.user_id] += 1
          end

        end
        
        # Make sure that each user is in only one have and in one need
        owns.keys.each { |x| needs[x].should eq(1) } and needs.keys.each { |x| owns[x].should eq(1) }
      end
    end
  end
  
  describe "Actual Trades" do
    before :each do

      @trades = User.all

    end
    it "each user should be in one trade line for own and one trade line for need in possible trades" do

      # For each trade count the number of times each user is in a hava and in a need
      @trades.each do |trade|
        owns = {}
        needs = {}
        
        trade.trade_lines.each do |line|
          if owns[line.inventory_own.user_id].nil?
            owns[line.inventory_own.user_id] = 1
          else
            owns[line.inventory_own.user_id] += 1
          end

          if needs[line.inventory_need.user_id].nil?
            needs[line.inventory_need.user_id] = 1
          else
            needs[line.inventory_need.user_id] += 1
          end

        end
        
        # Make sure that each user is in only one have and in one need
        owns.keys.each { |x| needs[x].should eq(1) } and needs.keys.each { |x| owns[x].should eq(1) }
      end
    end
  end
  	
end
