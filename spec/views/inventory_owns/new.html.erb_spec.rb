require 'spec_helper'

describe "inventory_owns/new" do
  before(:each) do
    assign(:inventory_own, stub_model(InventoryOwn,
      :book_id => 1,
      :user_id => 1,
      :condition => "MyString"
    ).as_new_record)
  end

  it "renders new inventory_own form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inventory_owns_path, "post" do
      assert_select "input#inventory_own_book_id[name=?]", "inventory_own[book_id]"
      assert_select "input#inventory_own_user_id[name=?]", "inventory_own[user_id]"
      assert_select "input#inventory_own_condition[name=?]", "inventory_own[condition]"
    end
  end
end
