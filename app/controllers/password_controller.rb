class PasswordController < ApplicationController
  def forgot_password
    if request.post?
      @user = User.find_by_email(params[:email])
      if @user 
        new_password = create_radom_password
        @user.update(:password => new_password)
        PostmanMailer.reset_password_notification(@user, new_password).deliver
        flash[:notice] = "New Password sent to #{@user.email}"
        redirect_to :controller => "accounts", :action => "login"
      else
        flash[:notice] = "User not found. Enter Valid email"
        render :action => "forgot_password"
      end
    end
  end

  def create_radom_password
    return (0...6).map { (65 + rand(26)).chr }.join
  end

  
  def reset_password
    if !session[:user]
      flash[:notice] = "Login to reset Password"
      redirect_to :controller => "accounts",:action => "login"
    else
      if request.post?
        if params[:password].blank? || params[:password_confirmation].blank?
          flash[:notice] = "Fields cannot be empty"
          redirect_to :action => "reset_password"

        elsif params[:password] != params[:password_confirmation]
          flash[:notice] = "Enter same passwords"
          redirect_to :action => "reset_password"

        else
          @user = User.find_by_id(session[:user])
          @user.update(:password => params[:password])
          flash[:notice] = "Password Updated"
        end

      end

    end 

  end


end
