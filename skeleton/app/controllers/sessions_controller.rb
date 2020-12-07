class SessionsController < ApplicationController
    before_action :login_user!
    def new
        render :new
    end

    def create
        user = User.find_credentials(
            params[:user][:username],
            params[:user][:password]
        )

        login_user!(user)
    end

    def destroy
        current_user.reset_session_token!
        session[:session_token]=nil
        redirect_to new_session_url # login page
    end


end
