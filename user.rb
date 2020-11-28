require_relative "user_controller"

module User
  def creater_user
    user_data = user_form

    @user = UserController.create(user_data)
  end
end
