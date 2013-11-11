require 'spec_helper'

describe "feedbacks/edit" do
  before(:each) do
    @feedback = assign(:feedback, stub_model(Feedback,
      :type => "",
      :image => "MyString"
    ))
  end

  it "renders the edit feedback form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", feedback_path(@feedback), "post" do
      assert_select "input#feedback_type[name=?]", "feedback[type]"
      assert_select "input#feedback_image[name=?]", "feedback[image]"
    end
  end
end
