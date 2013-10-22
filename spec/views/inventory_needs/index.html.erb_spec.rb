require 'spec_helper'

describe "inventory_needs/index" do
  before(:each) do
    assign(:inventory_needs, [
      stub_model(InventoryNeed,
        :book_id => 1,
        :user_id => 2
      ),
      stub_model(InventoryNeed,
        :book_id => 1,
        :user_id => 2
      )
    ])
  end

  it "renders a list of inventory_needs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
