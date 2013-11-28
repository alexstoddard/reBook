require 'spec_helper'

describe Trade do

  before :each do
    @users = User.all.collect { |x| x.id }
  end

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
      @trades = Trade.all
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

    it "should have (completed? => all trade line are accepted) and (all trade lines are accepted => completed?)" do
      @trades.each do |trade|
        
        if trade.completed?
          expect(trade.trade_lines.all? { |y| y.user_from_accepted }).to be_true
        end

        if trade.trade_lines.all? { |y| y.user_from_accepted }
          expect(trade.completed?).to be_true
        end
      end
    end

    it "should have (declined? => no trade line are accepted) and (no trade lines are accepted => declined?)" do
      @trades.each do |trade|
        
        if trade.declined?
          expect(trade.trade_lines.all? { |y| y.user_from_accepted == false}).to be_true
        end

        if trade.trade_lines.all? { |y| y.user_from_accepted == false}
          expect(trade.declined?).to be_true
        end
      end
    end

    it "should have be in right bucket from trades_by_needs" do
      
      @users.each do |user_id|
        hash = Trade.trades_by_needs(user_id)

        hash.keys.each do |need_id|
          possible = hash[need_id][:possible]
          accepted = hash[need_id][:accepted]
          active = hash[need_id][:active]
          completed = hash[need_id][:completed]
          declined = hash[need_id][:declined]
          
          expect(accepted.all? { |x| x.accepted?(user_id) }).to be_true
          expect(active.all? { |x| x.active?(user_id) }).to be_true
          expect(completed.all? { |x| x.completed? }).to be_true
          expect(declined.all? { |x| x.declined? }).to be_true
        end
      end
    end
  end
end
