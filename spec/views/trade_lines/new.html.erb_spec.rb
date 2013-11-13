require 'spec_helper'

describe "trade_lines/new" do
  before(:each) do
    assign(:trade_line, stub_model(TradeLine,
      :user_from_id => 1,
      :book_id => 1,
      :user_to_id => 1,
      :user_from_accepted => false
    ).as_new_record)
  end

  it "renders new trade_line form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", trade_lines_path, "post" do
      assert_select "input#trade_line_user_from_id[name=?]", "trade_line[user_from_id]"
      assert_select "input#trade_line_book_id[name=?]", "trade_line[book_id]"
      assert_select "input#trade_line_user_to_id[name=?]", "trade_line[user_to_id]"
      assert_select "input#trade_line_user_from_accepted[name=?]", "trade_line[user_from_accepted]"
    end
  end
end
