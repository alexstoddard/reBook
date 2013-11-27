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
end
