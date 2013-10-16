require 'spec_helper'

describe "user_feedbacks/show" do
  before(:each) do
    @user_feedback = assign(:user_feedback, stub_model(UserFeedback,
      :user_from_id => 1,
      :user_to_id => 2,
      :feedback_id => 3,
      :comment => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/MyText/)
  end
end
