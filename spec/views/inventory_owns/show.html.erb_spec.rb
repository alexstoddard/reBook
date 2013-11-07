require 'spec_helper'

describe "inventory_owns/show" do
  before(:each) do
    @inventory_own = assign(:inventory_own, stub_model(InventoryOwn,
      :book_id => 1,
      :user_id => 2,
      :condition => "Condition"
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
