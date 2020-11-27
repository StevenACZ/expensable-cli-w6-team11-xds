require_relative "presenter"
require_relative "requester"
require_relative "user"
require_relative "session"
require_relative "categories"
require_relative "transaction"

class Expensable
  include Presenter
  include Requester
  include User
  include Session
  include Categories
  include Transaction

  def initialize
    @user = nil
    @categories = nil
    @toggle = false
    @current_month = Date.today
  end

  def start
    until print_welcome
      action, _id = select_main_menu_action
      case action
      when "login" then login
      when "create_user" then creater_user
      when "exit" then break
      end
      categories_page if @user
    end
  end

  def categories_page
    load_categories
    puts "Welcome back #{@user[:first_name]} #{@user[:last_name]}"
    print_categories
    action, id = select_categories_menu_action
    until action == "logout"
      case action
      when "create" then create_category
      when "show" then show_category(id)
      when "update" then update_category(id)
      when "delete" then delete_category(id)
      when "add-to" then add - to_category(id)
      when "toggle" then toggle_category
      when "next" then next_month
      when "prev" then prev_month
      end
      print_categories
      action, id = select_categories_menu_action
    end
  end
end

app = Expensable.new
app.start
