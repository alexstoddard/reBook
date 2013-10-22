require 'spec_helper'

describe "books/index" do
  before(:each) do
    assign(:books, [
      stub_model(Book,
        :name => "Name",
        :subject => "Subject",
        :author => "Author",
        :edition => "Edition",
        :price => "9.99",
        :googleId => "Google",
        :thumbnail => "Thumbnail"
      ),
      stub_model(Book,
        :name => "Name",
        :subject => "Subject",
        :author => "Author",
        :edition => "Edition",
        :price => "9.99",
        :googleId => "Google",
        :thumbnail => "Thumbnail"
      )
    ])
  end

  it "renders a list of books" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "Edition".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Google".to_s, :count => 2
    assert_select "tr>td", :text => "Thumbnail".to_s, :count => 2
  end
end
