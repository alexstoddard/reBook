class Trade < ActiveRecord::Base


  # Relationships
  has_many :user_feedbacks, dependent: :destroy
  has_many :trade_lines, dependent: :destroy
  has_many :trade_notes, dependent: :destroy

  # This function performs user acceptance of a trade.
  # In our system this has possible outside consequence.
  # If a user accepts a trade, and any of the books that
  # are involved in that trade are also involved with other
  # trades, then the other trades are automatically invalidated.
  # That constraint is reflected in this function
  def user_accept(user_id)
    
    user = User.find(user_id)
    # For each trade line
    trade_lines.each do |x|
      if x.inventory_own.user_id == user_id
        # We accept only the user's portion of the trade
        x.user_from_accepted = true
        x.save
        
        # If this inventory item is involved in other trades
        # then those trades are invalidated
        user_own(user_id).inventory_own.trades.each do |y|
          if y.id != x.id
            y.trade_lines.each do |z|
              z.user_from_accepted = false
              z.save
            end
          end
        end

        # If this inventory item is involved in other trades
        # then those trades are invalidated
        user_need(user_id).inventory_need.trades.each do |y|
          if y.id != x.id
            y.trade_lines.each do |z|
              z.user_from_accepted = false
              z.save
            end
          end
        end

      end
    end
  end

  # Examines the trade lines and finds the one corresponding
  # to the line that contains a particular user's need.
  def user_need(user_id)
    trade_lines.each do |x|
      if x.inventory_need.user_id == user_id
        return x
      end
    end
  end

  # Examines the trade lines and finds the one corresponding
  # to the line that contains a particular user's owned item.
  def user_own(user_id)
    trade_lines.each do |x|
      if x.inventory_own.user_id == user_id
        return x
      end
    end
  end

  # Possibly different from user_decline
  def reset_trades(x, user_id)


  end
  
  # This function perfoms the user declining the trade
  # Its meaning is straightforward. It invalidates the
  # trade by setting all acceptance status to false.
  def user_decline(user_id)
    trade_lines.each { |x| x.user_from_accepted = false }
    trade_lines.each { |x| x.save }
  end
  
  # This function perfoms the user update of a trade
  # Its meanin is a little tricky. When a user declines,
  # all prior user's acceptances cease to matter. The terms
  # of the trade have changed, and only the current user
  # will have agreed to them. Accordingly we set only the
  # user's acceptance to true and everyone else to false.
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

  # Creates a new note to be assocated with this particular trade.
  def append_note(user_id, note)
    note.user_id = user_id
    trade_notes << note
  end

  #Get tradelines for a trade excluding the one corresponding 
  #to the given user_id (excluding the tradeline where given 
  #user is the one with the inventory_own book)
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
  
  # This fuction gets the trades assocated with a particular member 
  # of the user's inventory of needs. The trades will be in different
  # categories, and we put them in a hash to show this distinction. 
  # 4 categories of trade: (:accepted, :possible, :active, :declined, :completed)
  # :accepted => The user has agreed to these trades
  # :possible => These are trades which could be made but have no action taken yet.
  # :active => These are trades which involve the user, but they haven't confirmed.
  # :declined => These are trades which the user has indicated they don't want.
  # :completed => These are trades which everyone has accepted.
  # Access the categories like this Trade.trades_by_need(user, need)[:accepted]
  def self.trades_by_need(user_id, need_id) 
    need_hash = trades_by_needs(user_id)
    return need_hash[need_id]
  end

  # Private utility function to create the hash used for trades_by_need.
  # Create the hash so that every collection exists before iteration
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

  # Private function which takes each trade in a list and puts it in a 
  # hash where the key is the inventory_need_id of the trade where the 
  # user is participating. The function puts the matches in a sublist which
  # is determined by the symbol parameter it is passed
  def self.hash_trades(book_hash, trades, symbol, user_id)
    trades.each do |x|
      line = x.trade_lines.find { |y| y.inventory_need.user_id == user_id }
      unless line.nil?
        found_id = line.inventory_need_id
        book_hash[found_id][symbol] <<= x
      end
    end
  end
  
  # Function which abstracts how we are sending and storing JSON between 
  # calls to a view. 
  def escaped_json
    json = to_json(:include => :trade_lines)
    return CGI.escape(json)
  end
  
  # Reversal function for escaped_json
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

  # Determines whether or not the given inventory owns fit our
  # definition of not participating actively in a trade. All inventory
  # owns in the collection must pass this test, otherwise the combination
  # of them in a trade would be invalid
  def self.not_in_owns(owns)
    not owns.any? do |x| 
      lines = x.trade_lines

      lines.any? do |line|
        ( (not line.nil?) and line.user_from_accepted == true)
      end
    end
  end

  # Determines whether or not the given inventory needs fit our
  # definition of not participating actively in a trade. All inventory
  # needs in the collection must pass this test, otherwise the combination
  # of them in a trade would be invalid
  def self.not_in_needs(needs)
    not needs.any? do |x|
      trades = x.trades
      trades.any? { |y| y.user_own(x.user_id).user_from_accepted }
    end
  end

  # This function returns trades which do not exist yet but are possible given
  # the books in peoples inventories
  def self.possible_trades(user)
    trades = []

    # Available 2 person trades
    x = InventoryOwn.where(:user_id => user).includes(:need_matches => {:user_owns => :need_matches })

    # This is a big ol' join. We have a large opportunity to optimize this if needed
    x.each do | o1 |
      o1.need_matches.each do | n1 |
        n1.user_owns.each do | o2 |
          o2.need_matches.each do | n2 |
            if n2.user_id == user and not_in_owns [o1, o2] and not_in_needs [n1, n2]
              # If here this means that the combination of needs and wants does not break
              # any of our restrictions. We can call this a possible trade.
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

    # This is a big, big ol' join. We have a large opportunity to optimize this if needed
    x.each do | o1 |
      o1.need_matches.each do | n1 |
        n1.user_owns.each do | o2 |
          o2.need_matches.each do | n2 |
            n2.user_owns.each do | o3 |
              o3.need_matches.each do | n3 |
                if n3.user_id == user and not_in_owns [o1, o2, o3] and not_in_needs [n1, n2, n3]
                  # If here this means that the combination of needs and wants does not break
                  # any of our restrictions. We can call this a possible trade.
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

  # Divides a list of trades into different categories. The way it does this is 
  # highly dependent on our definitions of trades and therefore can be changed
  # easily if we change those definitions.
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
       trades.select do |trade| 
         a = trade.trade_lines.any? do |line|
           line.user_from_accepted == true and line.inventory_own.user_id == user
         end
         b = trade.trade_lines.any? do |line|
           line.user_from_accepted == false and line.inventory_own.user_id != user
         end
         (a and b)
       end
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

    # Initialize the hash to avoid constantly checking for nil-ness in collections
    need_hash = create_need_hash(needs, filters.keys)

    # Magic happens here
    # 1) For each category we have defined to have a filter, we iterate on the category
    # 2) We grab the filtering procedure which defines this category from the hash
    # 3) We filter our list of trades by calling the procedure
    # 4) We take the resultant list and we hash the trades according to the inventory_need
    #    of the user, since this is how we need to access it from the user's point of 
    #    view
    filters.keys.each do |filter|
      proc = filters[filter]
      passed = proc.call(user_id, trades)
      self.hash_trades(need_hash, passed, filter, user_id)
    end

    return need_hash
  end

end

