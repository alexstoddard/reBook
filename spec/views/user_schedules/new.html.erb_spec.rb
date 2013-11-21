require 'spec_helper'

describe "user_schedules/new" do
  before(:each) do
    assign(:user_schedule, stub_model(UserSchedule).as_new_record)
  end

  it "renders new user_schedule form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_schedules_path, "post" do
    end
  end
end
