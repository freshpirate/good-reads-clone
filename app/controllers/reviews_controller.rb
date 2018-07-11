class ReviewsController < ApplicationController
    before_filter :require_user, only: [:create, :update, :destroy]

    def create
        @relationship = Review.new(params[:review])

        book = add_rating_to_book(@relationship.book, @relationship.rating.to_f)

        if @relationship.save && book.save
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
        new_rating = params[:review]['rating'].to_f
        book = update_rating_of_book(@relationship.book, old_rating, new_rating)

        if @relationship.update_attributes(params[:review]) && book.save
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
        
        remove_rating_from_book(@relationship.book, @relationship.rating.to_f).save

        @relationship.destroy
        flash[:success] = "Review deleted!"
        redirect_to book_path(@relationship.book)
    end

    private 
    
    def add_rating_to_book(book, rating)
        book.average_rating = ((book.average_rating * book.rating_count) + rating) / (book.rating_count + 1)
        book.rating_count = book.rating_count + 1
        return book
    end

    def remove_rating_from_book(book, rating)
        book.average_rating = ((book.average_rating * book.rating_count) - rating) / (book.rating_count - 1)
        book.rating_count = book.rating_count - 1
        return book
    end

    def update_rating_of_book(book, old_rating, new_rating)
        diff = new_rating - old_rating

        puts '*'*100
        puts "New Rating: #{new_rating}"
        puts "New Rating: #{old_rating}"

        book.average_rating = ((book.average_rating * book.rating_count) + diff ) / (book.rating_count)
        return book
    end
end