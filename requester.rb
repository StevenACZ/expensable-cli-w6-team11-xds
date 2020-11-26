module Requester
  def select_main_menu_action
    prompt = "login | create_user | exit"
    options = %w[login create_user exit]
    gets_option(prompt, options)
  end

  def select_categories_menu_action
    prompt = "create | show | update | delete | add-to | toggle | next | prev | logout"
    options = %w[create show update delete add-to toggle next prev logout]
    gets_option(prompt, options)
  end

  private

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
end
