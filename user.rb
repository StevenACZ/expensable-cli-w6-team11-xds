require_relative "user_controller"

module User
  def creater_user
    user_data = user_form

    @user = UserController.create(user_data)
  rescue Net::HTTPError => e
    puts
    # Entresamos al objeto e y entramos al hash parsed_response y imprimimos casa error en cada linea
    e.response.parsed_response["errors"].each { |error| puts error }
    puts
  end
end