class Trade < ActiveRecord::Base


  # Relationships
  has_many :user_feedbacks, dependent: :destroy
  has_many :trade_lines, dependent: :destroy
  has_many :trade_notes, dependent: :destroy

  def user_accept(user_id)
    trade_lines.each do |x|
      if x.inventory_own.user_id == user_id
        x.user_from_accepted = true
        x.save
      end
    end
  end

  def user_decline(user_id)
    trade_lines.each { |x| x.user_from_accepted = false }
    trade_lines.each { |x| x.save }
  end
  
  def user_update(user_id)
    trade_lines.each do |x|
      if x.inventory_own.user_id != user_id
        x.user_from_accepted = false 
      else
        x.user_from_accepted = true
      end
      x.save
    end
  end

  def append_note(user_id, note)
    note.user_id = user_id
    trade_notes << note
  end

  #get tradelines for a trade excluding the one corresponding 
  #to the given user_id (excluding the tradeline where given user is the one with the inventory_own book)
  def get_tradelines_except(user_id)
    filtered_tradelines = []

    trade_lines.each do |x|
      if x.inventory_own.user_id != user_id
        filtered_tradelines << x
      end
    end
    return filtered_tradelines 
  end

  #get the tradeline for a trade only matching the given user_id
  #(only the tradeline where the given user is the one with the inventory_own book)
  def get_tradeline_only(user_id)
    trade_lines.each do |x|
      if x.inventory_own.user_id == user_id
        return x
      end
    end
  end

  #get the tradeline that the user with given user_id is giving their book to
  #in case of two-way trades, get_trade_line_to and get_tradeline_from will be the same
  def get_tradeline_to(user_id)
    my_tradeline = get_tradeline_only(user_id)
    other_tradelines = get_tradelines_except(user_id)
    to_user = my_tradeline.inventory_need.user_id
    other_tradelines.each do |x|
      if x.inventory_own.user_id == to_user
        return x
      end
    end
  end

  #get the tradeline that the user with the given user_id is getting their book from
  #in case of two-way trades, get_tradeline_to and get_tradeline_from will be the same
  def get_tradeline_from(user_id)
    other_tradelines = get_tradelines_except(user_id)
    other_tradelines.each do |x|
      if x.inventory_need.user_id == user_id
        return x
      end
    end
  end

  def self.trades_by_need(user_id, need_id) 
    need_hash = trades_by_needs(user_id)
    return need_hash[need_id]
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
#    not owns.any? { |x| TradeLine.find_by_inventory_own_id(x.id) }
    not owns.any? do |x| 
      line = TradeLine.find_by_inventory_own_id(x.id)
      ( (not line.nil?) and line.user_from_accepted == true)
    end
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
#            if n2.user_id == user and not_in_needs [n1, n2] and not_in_owns [o1, o2]
            if n2.user_id == user and not_in_owns [o1, o2]
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
#                if n3.user_id == user and not_in_needs [n1, n2, n3] and not_in_owns [o1, o2, o3]
                if n3.user_id == user and not_in_owns [o1, o2, o3]
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

  def self.trades_by_needs(user_id) 

    trades = Trade.includes(:trade_lines)
    needs = InventoryNeed.find_all_by_user_id(user_id)
    
    # These are filters for the various types of situations a trade can exist in
    # To add another type, you need only map a symbol to a proc that returns a filtered
    # version of a trade collection
    filters = {
      # This filter returns trades which are possible for the user but which no on
      # has yet taken action on
      :possible => lambda do |user, trades|
       return possible_trades(user)
     end,
     # This filter returns trades for the user which are active and have been
     # accepted by the user (trades that are waiting on other users to accept)
     :accepted => lambda do |user, trades|
       a = trades.select do |trade| 
         trade.trade_lines.any? do |line|
           line.user_from_accepted == true and line.inventory_own.user_id == user
         end
       end
       b = trades.select do |trade| 
         trade.trade_lines.any? do |line|
           line.user_from_accepted == false and line.inventory_own.user_id != user
         end
       end
       (a and b)
     end,
     # This filter returns trades for the user which are active and have not
     # been accepted by the user (trades another user proposed)
     :active => lambda do |user, trades|
       trades.select do |trade| 
         a = (trade.trade_lines.any? do |line|
           line.inventory_own.user_id == user and line.user_from_accepted == false
         end)
         b = (trade.trade_lines.any? do |line|
           line.inventory_own.user_id != user and line.user_from_accepted == true
         end)
         (a and b)
       end
     end,
     # This filter returns trades for the user which are not accepted by any
     # party. That is, someone has declined
     :declined => lambda do |user, trades|
       trades.select do |trade| 
         trade.trade_lines.all? do |line|
           line.user_from_accepted == false
         end
       end
     end,
     # This filter returns trades for the user which are accepted by all parties.
     :completed =>  lambda do |user, trades|
       trades.select do |trade| 
         trade.trade_lines.all? do |line|
           line.user_from_accepted == true
         end
       end
     end
    }

    need_hash = create_need_hash(needs, filters.keys)

    filters.keys.each do |filter|
      proc = filters[filter]
      passed = proc.call(user_id, trades)
      self.hash_trades(need_hash, passed, filter, user_id)
    end

    return need_hash
  end

end

