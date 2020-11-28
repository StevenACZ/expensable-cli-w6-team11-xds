require_relative "session_controller"

module Session
  def login
    login_data = login_form

    @user = SessionController.login(login_data)
  end

  def logout
    @user = SessionController.logout(@user[:token])
    @user = nil
    @categories = nil
    @toggle = false
    @current_month = Date.today
    @transactions = nil
  end
end
