class Trade < ActiveRecord::Base

  # Relationships
  has_many :user_feedbacks, dependent: :destroy
  has_many :trade_lines, dependent: :destroy
  has_many :trade_notes, dependent: :destroy

  def self.matches(user_id)
    sql = "select u1.username as user_from, u2.username as user_to, b1.thumbnail as from_thumb, b1.name as from_title, b2.name as to_title, b2.thumbnail as to_thumb from inventory_owns o1, inventory_needs n1, books b1, users u1, inventory_owns o2, inventory_needs n2, books b2, users u2 where u1.id = o1.user_id and o1.book_id = n1.book_id and b1.id = o1.book_id and o2.user_id = n1.user_id and n1.user_id = u2.id and n2.book_id = o2.book_id and b2.id = o2.book_id and n2.user_id = o1.user_id and o1.user_id =" + user_id.to_s
    @records = ActiveRecord::Base.connection.execute(sql)
    return @records
  end

  def self.try_matches(user)
    @trades = []

    # Available 2 person trades
    x = InventoryOwn.where(:user_id => user).includes(:need_matches => {:user_owns => :need_matches })

    x.each do | o1 |
      o1.need_matches.each do | n1 |
        n1.user_owns.each do | o2 |
          o2.need_matches.each do | n2 |
            if n2.user_id == user # and not in trade line with accepted true
              trade = Trade.new

              l1 = trade.trade_lines.build()
              l2 = trade.trade_lines.build()
              
              l1.user_from_id = user
              l1.user_to_id = n1.user_id
              l1.book_id = o1.book_id

              l2.user_from_id = o2.user_id
              l2.user_to_id = user
              l2.book_id = n2.book_id

              @trades = @trades << trade
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
                if n3.user_id == user # and not in trade line with accepted true
                  trade = Trade.new

                  l1 = trade.trade_lines.build()
                  l2 = trade.trade_lines.build()
                  l3 = trade.trade_lines.build()

                  l1.user_from_id = user
                  l1.user_to_id = n1.user_id
                  l1.book_id = o1.book_id

                  l2.user_from_id = n1.user_id
                  l2.user_to_id = n2.user_id
                  l2.book_id = o2.book_id

                  l3.user_from_id = n2.user_id
                  l3.user_to_id = user
                  l3.book_id = n3.book_id

                  @trades = @trades << trade
                end
              end
            end
          end
        end
      end
    end

    return @trades
  end

end
