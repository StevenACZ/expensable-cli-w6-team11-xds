require_relative "presenter"
require_relative "requester"
require_relative "user"

class Expensable
  include Presenter
  include Requester
  include User

  def initialize
    @user = nil
  end
  
  def start
    until print_welcome
      action, _id = select_main_menu_action
      case action
      when "login" then login
      when "create_user" then creater_user
      when "exit" then break
      end
    end
  end
end

app = Expensable.new
app.start