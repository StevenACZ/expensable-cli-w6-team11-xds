require "terminal-table"

module Presenter
  def print_welcome
    puts "####################################"
    puts "#       Welcome to Expensable      #"
    puts "####################################"
  end

  def user_form
    email = gets_string("Email: ", required: true, email: true)
    password = gets_string("Password: ", length: 6, required: true)
    first_name = gets_string("First name: ")
    last_name = gets_string("Last name: ")
    phone = gets_string("Phone: ") # Regex valid "Required format: +51 111222333 or 111222333"
    { email: email, password: password, first_name: first_name, last_name: last_name, phone: phone }
  end

  def login_form
    email = gets_string("Email: ", email: true, required: true)
    password = gets_string("Password: ", length: 6, required: true)
    { email: email, password: password }
  end

  def valid_email?(email)
    email.match(URI::MailTo::EMAIL_REGEXP) ? true : false
  end

  def gets_string(prompt, required: false, length: 0, email: false)
    print prompt
    input = gets.chomp.strip
    input = get_empty(prompt, input) if required
    input = get_length(prompt, input, length) if length.positive?
    input = get_email(prompt, input) if email
    input
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
