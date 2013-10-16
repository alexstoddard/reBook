require 'spec_helper'

describe "books/show" do
  before(:each) do
    @book = assign(:book, stub_model(Book,
      :name => "Name",
      :subject => "",
      :author => "",
      :edition => "",
      :price => "",
      :googleId => "",
      :thumbnail => "Thumbnail"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Thumbnail/)
  end
end
