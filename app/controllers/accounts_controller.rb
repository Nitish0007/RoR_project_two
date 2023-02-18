class AccountsController < ApplicationController
    def signup
        @user = User.new
        if request.post?
            @user = User.new(user_params)
            if @user.save
                PostmanMailer.signup_notification(@user).deliver
                redirect_to :action => "login"
            else
                render :action => "signup"
            end
        end
    end

    def login
        if request.post?
            @user = User.authenticate(params[:email], params[:password])
            if @user
                session[:user] = @user.id
                redirect_to :action => "dashboard"
            else
                flash[:notice] = "Invalid Email/Password"
                render :action => "login"
            end
        end
    end

    def dashboard
        if !session[:user]
            redirect_to "accounts/login"
        else
            render :controller => 'accounts', :action => 'dashboard'
        end
    end

    def logout
        session.delete(:user)
        flash[:notice] = "You are Logged Out"
        redirect_to accounts_login_path
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :mobile, :dob, :password, :encrypted_password)
    end


end
