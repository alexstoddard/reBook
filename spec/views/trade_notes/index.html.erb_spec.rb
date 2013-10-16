require 'spec_helper'

describe "trade_notes/index" do
  before(:each) do
    assign(:trade_notes, [
      stub_model(TradeNote,
        :trade_id => 1,
        :place => "Place",
        :comment => "MyText",
        :user_id => 2
      ),
      stub_model(TradeNote,
        :trade_id => 1,
        :place => "Place",
        :comment => "MyText",
        :user_id => 2
      )
    ])
  end

  it "renders a list of trade_notes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Place".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
