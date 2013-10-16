require 'spec_helper'

describe "inventory_haves/edit" do
  before(:each) do
    @inventory_have = assign(:inventory_have, stub_model(InventoryHave,
      :book_id => 1,
      :user_id => 1,
      :condition_id => "MyString"
    ))
  end

  it "renders the edit inventory_have form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inventory_have_path(@inventory_have), "post" do
      assert_select "input#inventory_have_book_id[name=?]", "inventory_have[book_id]"
      assert_select "input#inventory_have_user_id[name=?]", "inventory_have[user_id]"
      assert_select "input#inventory_have_condition_id[name=?]", "inventory_have[condition_id]"
    end
  end
end
