require 'spec_helper'

describe "trade_notes/new" do
  before(:each) do
    assign(:trade_note, stub_model(TradeNote,
      :trade_id => 1,
      :place => "MyString",
      :comment => "MyText",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new trade_note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", trade_notes_path, "post" do
      assert_select "input#trade_note_trade_id[name=?]", "trade_note[trade_id]"
      assert_select "input#trade_note_place[name=?]", "trade_note[place]"
      assert_select "textarea#trade_note_comment[name=?]", "trade_note[comment]"
      assert_select "input#trade_note_user_id[name=?]", "trade_note[user_id]"
    end
  end
end
