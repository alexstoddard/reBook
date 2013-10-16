require 'spec_helper'

describe "books/new" do
  before(:each) do
    assign(:book, stub_model(Book,
      :name => "MyString",
      :subject => "",
      :author => "",
      :edition => "",
      :price => "",
      :googleId => "",
      :thumbnail => "MyString"
    ).as_new_record)
  end

  it "renders new book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", books_path, "post" do
      assert_select "input#book_name[name=?]", "book[name]"
      assert_select "input#book_subject[name=?]", "book[subject]"
      assert_select "input#book_author[name=?]", "book[author]"
      assert_select "input#book_edition[name=?]", "book[edition]"
      assert_select "input#book_price[name=?]", "book[price]"
      assert_select "input#book_googleId[name=?]", "book[googleId]"
      assert_select "input#book_thumbnail[name=?]", "book[thumbnail]"
    end
  end
end
