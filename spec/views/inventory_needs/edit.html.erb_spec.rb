require 'spec_helper'

describe "inventory_needs/edit" do
  before(:each) do
    @inventory_need = assign(:inventory_need, stub_model(InventoryNeed,
      :book_id => 1,
      :user_id => 1
    ))
  end

  it "renders the edit inventory_need form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inventory_need_path(@inventory_need), "post" do
      assert_select "input#inventory_need_book_id[name=?]", "inventory_need[book_id]"
      assert_select "input#inventory_need_user_id[name=?]", "inventory_need[user_id]"
    end
  end
end
