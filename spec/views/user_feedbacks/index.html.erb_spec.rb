require 'spec_helper'

describe "user_feedbacks/index" do
  before(:each) do
    assign(:user_feedbacks, [
      stub_model(UserFeedback,
        :user_from_id => 1,
        :user_to_id => 2,
        :feedback_id => 3,
        :comment => "MyText"
      ),
      stub_model(UserFeedback,
        :user_from_id => 1,
        :user_to_id => 2,
        :feedback_id => 3,
        :comment => "MyText"
      )
    ])
  end

  it "renders a list of user_feedbacks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
