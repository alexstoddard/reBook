require 'spec_helper'

describe "inventory_haves/show" do
  before(:each) do
    @inventory_have = assign(:inventory_have, stub_model(InventoryHave,
      :book_id => 1,
      :user_id => 2,
      :condition_id => "Condition"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Condition/)
  end
end
