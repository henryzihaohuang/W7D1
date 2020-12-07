class UsersController < ApplicationController
    before_action :login_user!
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        user = @user.save
        login_user!(user)

        # @user = User.create(user_params)
        # if @user.save
        #     session[:session_token] = @user.reset_session_token!
        #     redirect_to cats_url
        # else
        #     flash.now[:errors] = @user.errors.full_messages
        #     render :new
        # end
        
    end


    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
