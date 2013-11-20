class Trade < ActiveRecord::Base

  # Callbacks

  # Relationships
  has_many :user_feedbacks, dependent: :destroy
  has_many :trade_lines, dependent: :destroy
  has_many :trade_notes, dependent: :destroy

  # This function returns trades for the user which are active and have been
  # accepted by the user
  def self.accepted_trades(user)
    Trade.includes(:trade_lines).select do |trade| 
      trade.trade_lines.any? do |line|
        line.inventory_own.user_id == user and line.user_from_accepted == true
      end
    end
  end

  # This function returns trades for the user which are active and have not
  # been accepted by the user
  def self.active_trades(user)
    Trade.includes(:trade_lines).select do |trade| 
      trade.trade_lines.any? do |line|
        line.inventory_own.user_id == user and (line.user_from_accepted == false or line.user_from_accepted.nil?)
      end
    end
  end

#  def self.has_accepted_owns(owned) 
#    owned.
#  end

  def user_accept(user_id)
    trade_lines.each do |x|
      if x.inventory_own.user_id == user_id
        x.user_from_accepted = true
      end
    end
  end

  def user_decline(user_id)
    trade_lines.each { |x| x.user_from_accepted = false }
  end

  def self.trades_by_need(user_id, need_id) 
    need_hash = trades_by_needs(user_id)
    return need_hash[need_id]
  end

  def self.trades_by_needs(user_id) 


    possible_trades = Trade.possible_trades(user_id)
    active_trades = Trade.active_trades(user_id)
    accepted_trades = Trade.accepted_trades(user_id)
    
    needs = InventoryNeed.find_all_by_user_id(user_id)

    need_hash = create_need_hash(needs, [:possible, :accepted, :active])

    hash_trades(need_hash, possible_trades, :possible, user_id)
    hash_trades(need_hash, accepted_trades, :accepted, user_id)
    hash_trades(need_hash, active_trades, :active, user_id)

    return need_hash

  end

  def self.create_need_hash(needs, symbols)
    need_hash = { }

    needs.each do |x|
      need_hash[x.id] = {}
      symbols.each do |y|
        need_hash[x.id][y] = []
      end
    end

    return need_hash

  end

  def self.hash_trades(book_hash, trades, symbol, user_id)
    trades.each do |x|
      line = x.trade_lines.find { |y| y.inventory_need.user_id == user_id }
      found_id = line.inventory_need_id
      book_hash[found_id][symbol] <<= x
    end
  end

  def escaped_json
    json = to_json(:include => :trade_lines)
    return CGI.escape(json)
  end

  def self.json_to_trade(text)
    json = JSON.parse(CGI.unescape(text))
    trade = Trade.new

    json["trade_lines"].each do |x|
      line = trade.trade_lines.build()
      line.inventory_need_id = x["inventory_need_id"]
      line.inventory_own_id = x["inventory_own_id"]
      line.user_from_accepted = x["user_from_accepted"]

    end
    
    return trade

  end

  def self.not_in_owns(owns)
    not owns.any? { |x| TradeLine.find_by_inventory_own_id(x.id) }
  end

  def self.not_in_needs(needs)
    not needs.any? { |x| TradeLine.find_by_inventory_need_id(x.id) }
  end

  # This function returns trades which do not exist yet but are possible given
  # the books in peoples inventories
  def self.possible_trades(user)
    trades = []

    # Available 2 person trades
    x = InventoryOwn.where(:user_id => user).includes(:need_matches => {:user_owns => :need_matches })

    x.each do | o1 |
      o1.need_matches.each do | n1 |
        n1.user_owns.each do | o2 |
          o2.need_matches.each do | n2 |
            if n2.user_id == user and not_in_needs [n1, n2] and not_in_owns [o1, o2]
              trade = Trade.new

              l1 = trade.trade_lines.build()
              l2 = trade.trade_lines.build()
              
              l1.inventory_own_id = o1.id
              l1.inventory_need_id = n1.id
              l1.user_from_accepted = false

              l2.inventory_own_id = o2.id
              l2.inventory_need_id = n2.id
              l2.user_from_accepted = false

              trades = trades << trade
            end
          end
        end
      end
    end
   
    # Available 3 person trades
    y = InventoryOwn.where(:user_id => user).includes(:need_matches => {:user_owns => { :need_matches => {:user_owns => :need_matches} }})

    x.each do | o1 |
      o1.need_matches.each do | n1 |
        n1.user_owns.each do | o2 |
          o2.need_matches.each do | n2 |
            n2.user_owns.each do | o3 |
              o3.need_matches.each do | n3 |
                if n3.user_id == user and not_in_needs [n1, n2, n3] and not_in_owns [o1, o2, o3]
                  trade = Trade.new

                  l1 = trade.trade_lines.build()
                  l2 = trade.trade_lines.build()
                  l3 = trade.trade_lines.build()

                  l1.inventory_own_id = o1.id
                  l1.inventory_need_id = n1.id
                  l1.user_from_accepted = false

                  l2.inventory_own_id = o2.id
                  l2.inventory_need_id = n2.id
                  l2.user_from_accepted = false

                  l3.inventory_own_id = o3.id
                  l3.inventory_need_id = n3.id
                  l3.user_from_accepted = false
                  trades = trades << trade
                end
              end
            end
          end
        end
      end
    end

    return trades
  end
end
