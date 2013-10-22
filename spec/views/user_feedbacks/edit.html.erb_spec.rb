require 'spec_helper'

describe "user_feedbacks/edit" do
  before(:each) do
    @user_feedback = assign(:user_feedback, stub_model(UserFeedback,
      :user_from_id => 1,
      :user_to_id => 1,
      :feedback_id => 1,
      :comment => "MyText"
    ))
  end

  it "renders the edit user_feedback form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_feedback_path(@user_feedback), "post" do
      assert_select "input#user_feedback_user_from_id[name=?]", "user_feedback[user_from_id]"
      assert_select "input#user_feedback_user_to_id[name=?]", "user_feedback[user_to_id]"
      assert_select "input#user_feedback_feedback_id[name=?]", "user_feedback[feedback_id]"
      assert_select "textarea#user_feedback_comment[name=?]", "user_feedback[comment]"
    end
  end
end
