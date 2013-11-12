require 'spec_helper'

describe "trade_lines/index" do
  before(:each) do
    assign(:trade_lines, [
      stub_model(TradeLine,
        :user_from_id => 1,
        :book_id => 2,
        :user_to_id => 3,
        :user_from_accepted => false
      ),
      stub_model(TradeLine,
        :user_from_id => 1,
        :book_id => 2,
        :user_to_id => 3,
        :user_from_accepted => false
      )
    ])
  end

  it "renders a list of trade_lines" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
