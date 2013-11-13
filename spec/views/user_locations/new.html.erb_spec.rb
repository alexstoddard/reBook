require 'spec_helper'

describe "user_locations/new" do
  before(:each) do
    assign(:user_location, stub_model(UserLocation,
      :user_id => 1,
      :location_id => 1,
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new user_location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_locations_path, "post" do
      assert_select "input#user_location_user_id[name=?]", "user_location[user_id]"
      assert_select "input#user_location_location_id[name=?]", "user_location[location_id]"
      assert_select "input#user_location_description[name=?]", "user_location[description]"
    end
  end
end
