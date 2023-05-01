class SessionsController < ApplicationController
  def new
  end

  def create
    # user = User.new email: params[:email], password: params[:password]
    user = User.find_by email: params[:email]

    if user&.password == params[:password]
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully"
    else
      redirect_to new_session_path,
                  status: :unprocessable_entity,
                  alert: "Invalid email or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully"
  end
end
