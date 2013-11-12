require 'spec_helper'

describe "conditions/show" do
  before(:each) do
    @condition = assign(:condition, stub_model(Condition,
      :description => "Description",
      :image => "Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    rendered.should match(/Image/)
  end
end
