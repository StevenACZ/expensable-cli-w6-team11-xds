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

  attr_reader :user, :categories, :toggle, :current_month, :transactions

  def initialize
    @user = nil
    @categories = nil
    @toggle = false
    @current_month = Date.today
    @transactions = nil
  end

  def start
    until print_welcome
      action, _id = select_main_menu_action
      begin
        case action
        when "login" then login
        when "create_user" then creater_user
        when "exit" then break
        end
      rescue Net::HTTPError => e
        e.response.parsed_response["errors"].each { |error| puts error }
        puts
      end
      categories_page if @user
    end
    print_end
  end

  def categories_page
    load_categories
    puts "Welcome back #{@user[:first_name]} #{@user[:last_name]}"
    until print_categories
      action, id = select_categories_menu_action
      begin
        case action
        when "create" then create_category
        when "show" then transaction_page(id)
        when "update" then update_category(id)
        when "delete" then delete_category(id)
        when "add-to" then add_to_category(id)
        when "toggle" then toggle_category
        when "next" then next_month
        when "prev" then prev_month
        when "logout" then break
        end
      rescue Net::HTTPError => e
        e.response.parsed_response["errors"].each { |error| puts error }
        puts
      end
    end
  end

  def transaction_page(category_id)
    load_transactions(category_id)
    until print_transaction(category_id)
      action, id = select_transaction_menu_action
      begin
        case action
        when "add" then add_transaction(category_id)
        when "update" then update_transaction(category_id, id)
        when "delete" then delete_transaction(category_id, id)
        when "next" then next_month
        when "prev" then prev_month
        when "back" then break
        end
      rescue Net::HTTPError => e
        e.response.parsed_response["errors"].each { |error| puts error }
        puts
      end
    end
  end
end

app = Expensable.new
app.start
