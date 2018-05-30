require 'spec_helper'

describe "books/show" do
  before(:each) do
    @book = assign(:book, stub_model(Book,
      :title => "Title",
      :isbn_number => "Isbn Number",
      :author => "Author",
      :synopsis => "Synopsis",
      :published_year => "Published Year",
      :language => "Language",
      :cover => "Cover",
      :publisher => "Publisher"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Isbn Number/)
    rendered.should match(/Author/)
    rendered.should match(/Synopsis/)
    rendered.should match(/Published Year/)
    rendered.should match(/Language/)
    rendered.should match(/Cover/)
    rendered.should match(/Publisher/)
  end
end
