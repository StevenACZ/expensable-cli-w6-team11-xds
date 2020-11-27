module Requester
  def select_main_menu_action
    prompt = "login | create_user | exit"
    options = %w[login create_user exit]
    gets_option(prompt, options)
  end

  def select_categories_menu_action
    prompt = "create | show ID | update ID | delete ID | add-to ID | toggle | next | prev | logout"
    options = %w[create show update delete add-to toggle next prev logout]
    gets_option(prompt, options)
  end

  def select_transaction_menu_action
    prompt = "add | update ID | delete ID | next | prev | back"
    options = %w[add update delete next prev back]
    gets_option(prompt, options)
  end

  def user_form
    email = gets_string("Email: ", required: true, email: true)
    password = gets_string("Password: ", length: 6, required: true)
    first_name = gets_string("First name: ")
    last_name = gets_string("Last name: ")
    phone = gets_string("Phone: ", valid_phone: true)
    { email: email, password: password, first_name: first_name, last_name: last_name, phone: phone }
  end

  def login_form
    email = gets_string("Email: ", email: true, required: true)
    password = gets_string("Password: ", length: 6, required: true)
    { email: email, password: password }
  end

  def transaction_form
    amount = gets_string("Amount: ", required: true, integer: true)
    date = gets_string("Date: ", required: true, valid_date: true)
    notes = gets_string("Notes: ")
    { amount: amount, notes: notes, date: date }
  end

  # rubocop:disable all
  def gets_string(prompt, required: false, length: 0, email: false, integer: false, valid_date: false, valid_phone: false)
    print prompt
    input = gets.chomp.strip
    input = get_empty(prompt, input) if required
    input = get_length(prompt, input, length) if length.positive?
    input = get_email(prompt, input) if email
    input = get_integer(prompt, input) if integer
    input = get_valid_date(prompt, input) if valid_date
    input = get_valid_phone(prompt, input) if valid_phone
    input
  end
  # rubocop:enable all

  def gets_option(prompt, options, required: true)
    puts prompt
    print "> "
    input = gets.chomp.split.map(&:strip)

    unless !required && input.empty?
      until options.include?(input[0])
        puts "Invalid option"
        print "> "
        input = gets.chomp.split.map(&:strip)
      end
    end
    input
  end

  private

  def valid_email?(email)
    email.match(URI::MailTo::EMAIL_REGEXP) ? true : false
  end

  def numeric?(obj)
    obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/).nil? ? false : true
  end

  def valid_date?(date)
    date.match(/(?<year>\d{4})-(?<month>\d{1,2})-(?<day>\d{1,2})/).nil? ? false : true
  end

  def valid_phone?(phone)
    (phone.match(/^\d{9}$/) || phone.match(/.+?5?1?\s?9\d{8}$/)).nil? ? false : true
  end

  def get_valid_phone(prompt, input)
    until valid_phone?(input)
      puts "Required format: +51 111222333 or 111222333"
      print prompt
      input = gets.chomp.strip
    end
    input
  end

  def get_valid_date(prompt, input)
    until valid_date?(input)
      puts "Required format: YYYY-MM-DD"
      print prompt
      input = gets.chomp.strip
    end
    input
  end

  def get_integer(prompt, input)
    until numeric?(input)
      puts "Invalid format: only integer data"
      print prompt
      input = gets.chomp.strip
    end
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
