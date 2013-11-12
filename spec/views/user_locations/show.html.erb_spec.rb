require 'spec_helper'

describe "user_locations/show" do
  before(:each) do
    @user_location = assign(:user_location, stub_model(UserLocation,
      :user_id => 1,
      :location_id => 2,
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Description/)
  end
end
