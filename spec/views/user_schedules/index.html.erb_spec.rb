require 'spec_helper'

describe "user_schedules/index" do
  before(:each) do
    assign(:user_schedules, [
      stub_model(UserSchedule),
      stub_model(UserSchedule)
    ])
  end

  it "renders a list of user_schedules" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
