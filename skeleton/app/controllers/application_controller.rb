class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?

    def current_user
        @user ||= Users.find_by(session_token: session[:session_token])
    end


    def logged_in?
        !!current_user
    end

    def ensure_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def login(user)
        session[:session_token] = user.reset_sesion_token!
    end

    def logout
        current_user.reset_session_token!
        session[:session_token]=nil
    end

    def login_user!(user)

        if user 
            session[:session_token] = user.reset_session_token!
            redirect_to cats_url
        else
            flash.now[:errors] = ["Invalid credentials"]
            render :new
        end

    end
    
end
