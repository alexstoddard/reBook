require 'spec_helper'

describe "books/show" do
  before(:each) do
    @book = assign(:book, stub_model(Book,
      :name => "Name",
      :subject => "Subject",
      :author => "Author",
      :edition => "Edition",
      :price => "9.99",
      :googleId => "Google",
      :thumbnail => "Thumbnail"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Subject/)
    rendered.should match(/Author/)
    rendered.should match(/Edition/)
    rendered.should match(/9.99/)
    rendered.should match(/Google/)
    rendered.should match(/Thumbnail/)
  end
end
