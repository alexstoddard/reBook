require 'spec_helper'

describe "inventory_needs/show" do
  before(:each) do
    @inventory_need = assign(:inventory_need, stub_model(InventoryNeed,
      :book_id => 1,
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
