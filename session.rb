require_relative "session_controller"

module Session
  def login
    login_data = login_form

    @user = SessionController.login(login_data)
  rescue Net::HTTPError => e
    e.response.parsed_response["errors"].each { |error| puts error }
    puts
  end

  def logout
    @user = SessionController.logout(@user[:token])
    @user = nil
    @categories = nil
    @toggle = false
    @current_month = Date.today
    @transactions = nil
  rescue Net::HTTPError => e
    e.response.parsed_response["errors"].each { |error| puts error }
    puts
  end
end
