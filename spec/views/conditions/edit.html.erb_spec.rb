require 'spec_helper'

describe "conditions/edit" do
  before(:each) do
    @condition = assign(:condition, stub_model(Condition,
      :description => "MyString",
      :image => "MyString"
    ))
  end

  it "renders the edit condition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", condition_path(@condition), "post" do
      assert_select "input#condition_description[name=?]", "condition[description]"
      assert_select "input#condition_image[name=?]", "condition[image]"
    end
  end
end
