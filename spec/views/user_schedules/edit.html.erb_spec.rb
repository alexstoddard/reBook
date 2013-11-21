require 'spec_helper'

describe "user_schedules/edit" do
  before(:each) do
    @user_schedule = assign(:user_schedule, stub_model(UserSchedule))
  end

  it "renders the edit user_schedule form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_schedule_path(@user_schedule), "post" do
    end
  end
end
