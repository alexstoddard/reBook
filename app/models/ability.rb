class Ability
  include CanCan::Ability
  
  def initialize(u)
	if u != nil
	  if u.admin?
      can :manage, :all
	  else
		#InventoryNeed and InventoryOwn Restriction
		can :manage, InventoryNeed
		can :manage, InventoryOwn
		
		#User Controller Restriction
		can :set_is_current_user, User
		cannot :index, User
		cannot :forgot, User
		can :edit_schedule, User
		cannot :forgot_do, User
		cannot :reset, User
		cannot :reset_do, User
		can :show, User
		cannot :new, User
		cannot :edit, User
		cannot :create, User
		can :update, User
		cannot :destroy, User
		
		#Trade Controller Restriction
		cannot :index, Trade
		can :accept_trade_show, Trade
		can :accept_trade, Trade
		can :decline_trade_show, Trade
		can :decline_trade, Trade
		can :update_trade_show, Trade
		can :update_trade, Trade
		can :propose_trade, Trade
		cannot :trade_details, Trade
		can :match_details, Trade
		can :my_trades, Trade
		can :matches, Trade
		cannot :show, Trade
		can :new, Trade
		can :edit, Trade
		can :create, Trade
		can :update, Trade
		can :destroy, Trade
		can :set_trade, Trade
		
		#Book Controller Restriction. 
		can :search, Book

		#User Feedback Restriction
		can :create, UserFeedback
	  end
	else
	  can :create, User
	  can :forgot, User
	  can :set_is_current_user, User
	  can :new, User
	  can :update, User
	  can :search, Book
	end
  end
end
