class UsersController < ApplicationController

    before_filter :require_no_user, :only => [:new, :create]
    before_filter :require_user, :only => [:edit, :update, :show, :destroy, :index]
    before_filter :correct_user,   only: [:edit, :update, :destroy]

    def index
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(users_params)
        if @user.save
            flash[:success] = "Registered Successfully!"
            redirect_to root_url
        else
            render :new
        end

    end

    def edit
    end

    def update
        @user = User.find(params[:id])

        if @user.update_attributes(params[:user])
            # update successful
            flash[:success] = "Profile updated"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def destroy
    end

    def show
        @user = User.find(params[:id])
        @relationships = @user.book_relationships.paginate(page: params[:page])
    end

    private

    def users_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name)
    end

    private

    def correct_user
        @user = User.find(params[:id])
        if !current_user?(@user)
            flash[:warning] = "Sign in with the appropriate User to perform this action"
            redirect_to root_url
        end
    end
end