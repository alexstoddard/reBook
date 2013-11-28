require 'spec_helper'

describe User do
  #VALIDATION TESTS
  it "Validate First Name presence" do
	@entries = User.count
	expect(User.new).to have(1).error_on(:first)
	expect(@entries).to eq(User.count)
  end
  
  it "Validate Last Name presence" do
    @entries = User.count
	expect(User.new).to have(1).error_on(:last)
	expect(@entries).to eq(User.count)
  end
  
  it "Validate User Name presence" do
    @entries = User.count
	expect(User.new).to have(2).error_on(:username)
	expect(@entries).to eq(User.count)
  end
  
  it "Validate Email presence" do
    @entries = User.count
	expect(User.new).to have(2).error_on(:email)
	expect(@entries).to eq(User.count)
  end
  
  it "Validate Passhash presence" do
    @entries = User.count
	expect(User.new).to have(2).error_on(:passhash)
	expect(@entries).to eq(User.count)
  end
  
  it "validate Passhash_confirmation presence" do
    @entries = User.count
	expect(User.new).to have(1).error_on(:passhash_confirmation)
	expect(@entries).to eq(User.count)
  end
  
  it "validate user location presence" do
    @entries = User.count
	expect(User.new).to have(1).error_on(:user_locations)
	expect(@entries).to eq(User.count)
  end
  
  it "Add Two users, with second user violating the validations, so the second user should not be added. " do
	@entries = User.count()
	User.enable_mailer = false
	#Add a valid user
	User.create(:username=>"username123",
				 :email => "ahhhahah@gmail.com",
				 :passhash => "abcdefgh",
				 :image => "imagessss",
				 :first => "user name",
				 :last => "bronze",
				 :activated => false,
				 :passhash_confirmation => "abcdefgh",
				 :terms => "1",
				 :user_locations=>[UserLocation.new(:location_id => 1, :description => "nice place")])
	expect(@entries).not_to eq(User.count())
	#Add a invalid user with not unique username
	@entries = User.count()
	expect(User.create(:username=>"username123",
				 :email => "ahhhahah@gmail.com",
				 :passhash => "abcdefgh",
				 :image => "imagessss",
				 :first => "user name",
				 :last => "bronze",
				 :activated => false,
				 :passhash_confirmation => "abcdefgh",
				 :terms => "1",
				 :user_locations=>[UserLocation.new(:location_id => 1, :description => "nice place")])
			).to have(1).error_on(:username)
	expect(@entries).to eq(User.count())
	#Add a invalid user with not unique email
	@entries = User.count()
	expect(User.create(:username=>"username1234",
				 :email => "ahhhahah@gmail.com",
				 :passhash => "abcdefgh",
				 :image => "imagessss",
				 :first => "user name",
				 :last => "bronze",
				 :activated => false,
				 :passhash_confirmation => "abcdefgh",
				 :terms => "1",
				 :user_locations=>[UserLocation.new(:location_id => 1, :description => "nice place")])
			).to have(1).error_on(:email)
	expect(@entries).to eq(User.count())
  end
end
