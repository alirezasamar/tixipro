class UsersController < DeviseController
  load_and_authorize_resource

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role_id)
  end

end
