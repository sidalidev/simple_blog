class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new params[:user].permit(:email, :password)
    if user.save
      session[:user_id] = user.id
      redirect_to root_path, notice: "Thanks for signing up!"
    else
      redirect_to new_registration_path,
                  alert: user.errors.full_messages.join(", ")
    end
  end
end
