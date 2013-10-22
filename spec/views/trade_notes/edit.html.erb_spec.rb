require 'spec_helper'

describe "trade_notes/edit" do
  before(:each) do
    @trade_note = assign(:trade_note, stub_model(TradeNote,
      :trade_id => 1,
      :place => "MyString",
      :comment => "MyText",
      :user_id => 1
    ))
  end

  it "renders the edit trade_note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", trade_note_path(@trade_note), "post" do
      assert_select "input#trade_note_trade_id[name=?]", "trade_note[trade_id]"
      assert_select "input#trade_note_place[name=?]", "trade_note[place]"
      assert_select "textarea#trade_note_comment[name=?]", "trade_note[comment]"
      assert_select "input#trade_note_user_id[name=?]", "trade_note[user_id]"
    end
  end
end