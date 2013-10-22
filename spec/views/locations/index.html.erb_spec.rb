require 'spec_helper'

describe "locations/index" do
  before(:each) do
    assign(:locations, [
      stub_model(Location,
        :name => "Name",
        :address => "Address",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :image => "Image",
        :icon => "Icon",
        :description => "MyText"
      ),
      stub_model(Location,
        :name => "Name",
        :address => "Address",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :image => "Image",
        :icon => "Icon",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "Icon".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
