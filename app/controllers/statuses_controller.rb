class StatusesController < ApplicationController

    def create
        @status = Status.new
        @status.status_id = params[:status_id]
        @status.user_id = current_user.id
        @status.book_id = params[:book_id]

        if @status.save
            flash[:success] = @status.book.title + " has been marked as: " + @status.status_category.name
            redirect_to @status.book
        else
            flash[:error] = "Failed to mark " + @status.book.title + " as: " + @status.status_category.name + ". Please try again!"
            redirect_to @status.book
        end
    end

    def update
        @status = Status.find(params[:id])
        @status.status_id = params[:status_id]

        if @status.save
            flash[:success] = @status.book.title + " has been marked as: " + @status.status_category.name
            redirect_to @status.book
        else
            flash[:error] = "Failed to mark " + @status.book.title + " as: " + @status.status_category.name + ". Please try again!"
            redirect_to @status.book
        end
    end

    def destroy
    end
end