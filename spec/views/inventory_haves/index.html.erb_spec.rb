require 'spec_helper'

describe "inventory_haves/index" do
  before(:each) do
    assign(:inventory_haves, [
      stub_model(InventoryHave,
        :book_id => 1,
        :user_id => 2,
        :condition_id => "Condition"
      ),
      stub_model(InventoryHave,
        :book_id => 1,
        :user_id => 2,
        :condition_id => "Condition"
      )
    ])
  end

  it "renders a list of inventory_haves" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Condition".to_s, :count => 2
  end
end
