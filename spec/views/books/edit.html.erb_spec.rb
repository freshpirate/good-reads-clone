require 'spec_helper'

describe "books/edit" do
  before(:each) do
    @book = assign(:book, stub_model(Book,
      :title => "MyString",
      :isbn_number => "MyString",
      :author => "MyString",
      :synopsis => "MyString",
      :published_year => "MyString",
      :language => "MyString",
      :cover => "MyString",
      :publisher => "MyString"
    ))
  end

  it "renders the edit book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => books_path(@book), :method => "post" do
      assert_select "input#book_title", :name => "book[title]"
      assert_select "input#book_isbn_number", :name => "book[isbn_number]"
      assert_select "input#book_author", :name => "book[author]"
      assert_select "input#book_synopsis", :name => "book[synopsis]"
      assert_select "input#book_published_year", :name => "book[published_year]"
      assert_select "input#book_language", :name => "book[language]"
      assert_select "input#book_cover", :name => "book[cover]"
      assert_select "input#book_publisher", :name => "book[publisher]"
    end
  end
end
