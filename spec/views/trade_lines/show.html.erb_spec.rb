require 'spec_helper'

describe "trade_lines/show" do
  before(:each) do
    @trade_line = assign(:trade_line, stub_model(TradeLine,
      :user_from_id => 1,
      :book_id => 2,
      :user_to_id => 3,
      :user_from_accepted => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/false/)
  end
end
