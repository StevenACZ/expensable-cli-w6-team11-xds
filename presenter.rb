require "terminal-table"

module Presenter
  def print_welcome
    puts "####################################"
    puts "#       Welcome to Expensable      #"
    puts "####################################"
  end

  def user_form
    email = gets_string("Email: ", error: "Invalid format")
    password = gets_string("Password: ", length: 6)
    first_name = gets_string("First name: ", length: 6)
    last_name = gets_string("Last name: ")
    phone = gets_string("Phone: ") #Regex valid "Required format: +51 111222333 or 111222333"
    { email: email, password: password, first_name: first_name, last_name: last_name, phone: phone }
  end

  def valid_email?(email)
    email.match(URI::MailTo::EMAIL_REGEXP) ? true : false
  end

  def gets_string(prompt, required: true, length: 0, error: "Can't be blank")
    print prompt
    input = gets.chomp.strip
    if required
      while input.empty? || input.size < length || !valid_email?(input)
        puts error if !valid_email?(input)
        puts error if input.empty?
        puts "Minimun lenght of #{length}" if input.size < length
        print prompt
        input = gets.chomp.strip
      end
    end
    input
  end
end