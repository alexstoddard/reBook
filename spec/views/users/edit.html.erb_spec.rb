require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :username => "MyString",
      :email => "MyString",
      :passhash => "MyString",
      :image => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_path(@user), "post" do
      assert_select "input#user_username[name=?]", "user[username]"
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "input#user_passhash[name=?]", "user[passhash]"
      assert_select "input#user_image[name=?]", "user[image]"
    end
  end
end
