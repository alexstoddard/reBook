require 'spec_helper'

describe "user_locations/edit" do
  before(:each) do
    @user_location = assign(:user_location, stub_model(UserLocation,
      :user_id => 1,
      :location_id => 1,
      :description => "MyString"
    ))
  end

  it "renders the edit user_location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_location_path(@user_location), "post" do
      assert_select "input#user_location_user_id[name=?]", "user_location[user_id]"
      assert_select "input#user_location_location_id[name=?]", "user_location[location_id]"
      assert_select "input#user_location_description[name=?]", "user_location[description]"
    end
  end
end
