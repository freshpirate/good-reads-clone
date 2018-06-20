class UsersController < ApplicationController

    before_filter :require_no_user, :only => [:new, :create]
    before_filter :require_user, :only => [:edit, :update, :show, :destroy, :index]
    before_filter :correct_user,   only: [:edit, :update, :destroy]

    def index
        @users = User.paginate(page: params[:page])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(users_params)
        @user.confirmation_token = gen_token

        if @user.save
            
            # Send confirmation mail
            # UserMailer.new_user(@user).deliver
            SendMailWorker.perform_async(@user.id)

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

    def confirm
        @user = User.find(params[:id])
        if @user.confirmation_token == params[:token]
            if @user.update_attributes(email_confirmation: true)
                # update successful
                flash[:success] = "Email confirmation successful! Now you can sign in to access our contents"
                redirect_to root_url
            else
                flash[:error] = "Can not update"
                redirect_to root_url
            end

        else
            flash[:error] = "Invalid Token"
            redirect_to root_url
        end
    end

    private

    def users_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name)
    end

    def correct_user
        @user = User.find(params[:id])
        if !current_user?(@user)
            flash[:warning] = "Sign in with the appropriate User to perform this action"
            redirect_to root_url
        end
    end

    def gen_token(length=128)
        rand(36**length).to_s(36)
    end
end