require 'spec_helper'

describe "inventory_needs/new" do
  before(:each) do
    assign(:inventory_need, stub_model(InventoryNeed,
      :book_id => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new inventory_need form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inventory_needs_path, "post" do
      assert_select "input#inventory_need_book_id[name=?]", "inventory_need[book_id]"
      assert_select "input#inventory_need_user_id[name=?]", "inventory_need[user_id]"
    end
  end
end
