class ProfileController < ApplicationController
  def edit_profile
    @user = User.find_by_id(session[:user])
    if request.post?
      if @user
        if @user.update(user_params)
            redirect_to accounts_dashboard_url
        else
          puts @user.errors.full_messages
          render :action => :edit_profile
        end
      end
    end
  end

  def user_params
    params.require(:user).permit(:image, :first_name, :last_name, :mobile, :dob)
  end

end
