class ReviewsController < ApplicationController
  before_filter :require_user, only: [:create, :update, :destroy]

  def create
    @relationship = Review.new(params[:review])

    book = add_rating_to_book(@relationship.book, @relationship.rating.to_f)

    relationship_saved, book_updated = false, false
    Book.transaction do
      relationship_saved = @relationship.save
      book_updated = book.save
    end

    if relationship_saved && book_updated
      flash[:success] = "Review added successfully!"
      redirect_to book_path(@relationship.book)
    else
      flash[:error] = "Could not add your review. Sorry for the inconvinience. Try again"
      redirect_to book_path(@relationship.book)
    end
  end

  def update
    @relationship = Review.find(params[:id])

    old_rating = @relationship.rating.to_f
    new_rating = params[:review]["rating"].to_f
    book = update_rating_of_book(@relationship.book, old_rating, new_rating)

    relationship_updated, book_saved = false, false
    Book.transaction do
      relationship_updated = @relationship.update_attributes(params[:review])
      book_saved = book.save
    end

    if relationship_updated && book_saved
      # update successful
      flash[:success] = "Review updated"
      redirect_to book_path(@relationship.book)
    else
      flash[:error] = "Could not update the review"
      redirect_to book_path(@relationship.book)
    end
  end

  def destroy
    @relationship = Review.find(params[:id])

    relationship_destroyed, book_updated = false, false
    Book.transaction do
      relationship_destroyed = @relationship.destroy
      book_updated = remove_rating_from_book(@relationship.book, @relationship.rating.to_f).save
    end

    if relationship_destroyed && book_updated
      # update successful
      flash[:success] = "Review deleted!"
      redirect_to book_path(@relationship.book)
    else
      flash[:error] = "Could not delete the review"
      redirect_to book_path(@relationship.book)
    end
  end

  private

  def add_rating_to_book(book, rating)
    book.average_rating = ((book.average_rating * book.rating_count) + rating) / (book.rating_count + 1)
    book.rating_count = book.rating_count + 1
    book
  end

  def remove_rating_from_book(book, rating)
    book.average_rating = ((book.average_rating * book.rating_count) - rating) / (book.rating_count - 1)
    book.rating_count = book.rating_count - 1
    book
  end

  def update_rating_of_book(book, old_rating, new_rating)
    diff = new_rating - old_rating

    puts "*" * 100
    puts "New Rating: #{new_rating}"
    puts "New Rating: #{old_rating}"

    book.average_rating = ((book.average_rating * book.rating_count) + diff) / (book.rating_count)
    book
  end
end
