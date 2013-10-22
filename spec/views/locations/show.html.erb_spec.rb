require 'spec_helper'

describe "locations/show" do
  before(:each) do
    @location = assign(:location, stub_model(Location,
      :name => "Name",
      :address => "Address",
      :city => "City",
      :state => "State",
      :zip => "Zip",
      :image => "Image",
      :icon => "Icon",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Address/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Zip/)
    rendered.should match(/Image/)
    rendered.should match(/Icon/)
    rendered.should match(/MyText/)
  end
end
