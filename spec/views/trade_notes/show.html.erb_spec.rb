require 'spec_helper'

describe "trade_notes/show" do
  before(:each) do
    @trade_note = assign(:trade_note, stub_model(TradeNote,
      :trade_id => 1,
      :place => "Place",
      :comment => "MyText",
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Place/)
    rendered.should match(/MyText/)
    rendered.should match(/2/)
  end
end
