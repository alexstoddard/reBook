require 'spec_helper'

describe "user_locations/index" do
  before(:each) do
    assign(:user_locations, [
      stub_model(UserLocation,
        :user_id => 1,
        :location_id => 2,
        :description => "Description"
      ),
      stub_model(UserLocation,
        :user_id => 1,
        :location_id => 2,
        :description => "Description"
      )
    ])
  end

  it "renders a list of user_locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
