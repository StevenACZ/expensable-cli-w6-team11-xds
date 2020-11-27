require "terminal-table"
require "date"

module Presenter
  def print_welcome
    puts "####################################"
    puts "#       Welcome to Expensable      #"
    puts "####################################"
  end

  def print_categories
    table = @toggle ? print_expense : print_income
    puts table
  end

  def print_expense
    table = Terminal::Table.new
    table.title = "Income\n#{@current_month.strftime('%B')} #{@current_month.strftime('%Y')}"
    table.headings = %w[ID Category Total]
    table.rows = category_filter_expense
    table
  end

  def print_income
    table = Terminal::Table.new
    table.title = "Expenses\n#{@current_month.strftime('%B')} #{@current_month.strftime('%Y')}"
    table.headings = %w[ID Category Total]
    table.rows = category_filter_income
    table
  end

  def category_filter_expense
    categories_filter = @categories.reject do |category|
      category[:transaction_type] == "expense"
    end

    categories_filter.map do |category_filter|
      [
        category_filter[:id],
        category_filter[:name],
        category_filter[:transactions].map do |transaction|
          if (transaction[:date].split("-"))[1] == @current_month.strftime("%m")
            transaction[:amount]
          else
            0
          end
        end.sum
      ]
    end
  end

  def category_filter_income
    categories_filter = @categories.reject do |category|
      category[:transaction_type] == "income"
    end

    categories_filter.map do |category_filter|
      [
        category_filter[:id],
        category_filter[:name],
        category_filter[:transactions].map do |transaction|
          if (transaction[:date].split("-"))[1] == @current_month.strftime("%m")
            transaction[:amount]
          else
            0
          end
        end.sum
      ]
    end
  end

  def user_form
    email = gets_string("Email: ", required: true, email: true)
    password = gets_string("Password: ", length: 6, required: true)
    first_name = gets_string("First name: ")
    last_name = gets_string("Last name: ")
    phone = gets_string("Phone: ")
    { email: email, password: password, first_name: first_name, last_name: last_name, phone: phone }
  end

  def categorie_form
    name = gets_categorie("Name: ", required: true)
    transaction_type = gets_categorie("Transaction type: ", required: true, type: true)
    { name: name, transaction_type: transaction_type }
  end

  def login_form
    email = gets_string("Email: ", email: true, required: true)
    password = gets_string("Password: ", length: 6, required: true)
    { email: email, password: password }
  end

  def valid_email?(email)
    email.match(URI::MailTo::EMAIL_REGEXP) ? true : false
  end

  def valid_transaction_type?(type)
    # if type == "income" || type == "expense"
    # else puts "Only income or expense"
    # end
  end

  def gets_string(prompt, required: false, length: 0, email: false)
    print prompt
    input = gets.chomp.strip
    input = get_empty(prompt, input) if required
    input = get_length(prompt, input, length) if length.positive?
    input = get_email(prompt, input) if email
    input
  end

  def gets_categorie(prompt, _input)
    print prompt
    gets.chomp.strip
  end

  def get_email(prompt, input)
    until valid_email?(input)
      puts "Invalid format" unless valid_email?(input)
      print prompt
      input = gets.chomp.strip
    end
    input
  end

  def get_length(prompt, input, length)
    while input.size < length
      puts "Minimun lenght of #{length}" if input.size < length
      print prompt
      input = gets.chomp.strip
    end
    input
  end

  def get_empty(prompt, input)
    while input.empty?
      puts "Can't be blank" if input.empty?
      print prompt
      input = gets.chomp.strip
    end
    input
  end
end
