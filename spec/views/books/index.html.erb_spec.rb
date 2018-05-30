require 'spec_helper'

describe "books/index" do
  before(:each) do
    assign(:books, [
      stub_model(Book,
        :title => "Title",
        :isbn_number => "Isbn Number",
        :author => "Author",
        :synopsis => "Synopsis",
        :published_year => "Published Year",
        :language => "Language",
        :cover => "Cover",
        :publisher => "Publisher"
      ),
      stub_model(Book,
        :title => "Title",
        :isbn_number => "Isbn Number",
        :author => "Author",
        :synopsis => "Synopsis",
        :published_year => "Published Year",
        :language => "Language",
        :cover => "Cover",
        :publisher => "Publisher"
      )
    ])
  end

  it "renders a list of books" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Isbn Number".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "Synopsis".to_s, :count => 2
    assert_select "tr>td", :text => "Published Year".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => "Cover".to_s, :count => 2
    assert_select "tr>td", :text => "Publisher".to_s, :count => 2
  end
end
