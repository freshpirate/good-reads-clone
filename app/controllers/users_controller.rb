class UsersController < ApplicationController

    before_filter :require_no_user, :only => [:new, :create]
    before_filter :require_user, :only => [:edit, :update, :show, :destroy, :index]
    before_filter :correct_user,   only: [:edit, :update, :destroy]
    before_filter :find_user_by_params, only: [:update, :show, :confirm]

    def index
        @users = User.paginate(page: params[:page])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(users_params)
        @user.confirmation_token = gen_token

        saved = @user.save

        respond_to do |format| 
            format.html do

                if saved
                    # Send confirmation mail
                    # UserMailer.new_user(@user).deliver
                    p '^'*100
                    SendMailWorker.perform_async(@user.id)

                    flash[:success] = "Registered Successfully!"
                    redirect_to root_url
                else
                    # flash[:error] = "Can not create the user"
                    render :new
                end
            end

            format.json do
                json_obj = {}

                if saved
                    json_obj["error"] = false
                    json_obj["status"] = {}
                    json_obj["user"] = @user
                    render json: json_obj
                else
                    json_obj["error"] = true
                    json_obj["status"] = {
                        "messages": @user.errors.full_messages
                    }
                    # json_obj["user"] = @user
                    render json: json_obj
                end
                
            end
        end

    end

    def edit
    end

    def update
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
        @relationships = @user.reviews.paginate(page: params[:page]).preload(:book)
    end

    def confirm
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

    def gen_token(length=128)
        rand(36**length).to_s(36)
    end
end