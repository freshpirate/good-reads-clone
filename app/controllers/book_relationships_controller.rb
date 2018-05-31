class BookRelationshipsController < ApplicationController
    
    def create
        puts '========BEFORE========='
        @relationship = BookRelationship.new(params[:book_relationship])
        # @relationship.user = current_user
        # @relationship.book=
        puts @relationship.attributes
        puts '========Mid========='
        if @relationship.save
            flash[:success] = "Review added successfully!"
            redirect_to book_path(@relationship.book)
        else
            flash[:error] = "Could not add your review. Sorry for the inconvinience. Try again"
            redirect_to book_path(@relationship.book)
        end
    end

    def update
        @relationship = BookRelationship.find(params[:id])

        if @relationship.update_attributes(params[:book_relationship])
            # update successful
            flash[:success] = "Review updated"
            redirect_to book_path(@relationship.book)
        else
            flash[:error] = "Could not update the review"
            redirect_to book_path(@relationship.book)
        end
    end

    def destroy
        @relationship = BookRelationship.find(params[:id])
        @relationship.destroy
        flash[:success] = "Review deleted!"
        redirect_to book_path(@relationship.book)
    end
end