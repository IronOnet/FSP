class V1::SessionsController < ApplicationController

  ##need to rework to protect destroy method 
#########################################################
  def create
    email = params[:user][:email]
    password = params[:user][:password]
    @user = User.find_by_credentials(email, password)

    if @user
      log_in!(@user)
      render json: {
        logged_in: true,
        user: current_user
        }

    else
      render json: {error: 401}
    end
  end


  def destroy
    @user = current_user
    if @user
      log_out!
      render json: {
        status: 200,
        logged_out: true,
        }
    else
      render json: { error: "No current user"}, status: 404
    end
  end

end