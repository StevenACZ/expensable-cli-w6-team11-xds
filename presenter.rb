require "terminal-table"
require "date"
require "time"

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

  def print_transaction(category_id)
    index = @categories.find_index { |category| category[:id] == category_id.to_i }
    table = Terminal::Table.new
    table.title = "#{@categories[index][:name]}\n#{@current_month.strftime('%B')} #{@current_month.strftime('%Y')}"
    table.headings = %w[ID Date Amount Notes]
    table.rows = transaction_filter
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

  private

  def transaction_filter
    transactions_filter = @transactions.select do |transaction|
      (transaction[:date].split("-"))[1] == @current_month.strftime("%m")
    end

    transactions_filter.map do |transaction|
      [
        transaction[:id],
        Time.parse(transaction[:date]).strftime("%a, %b %d"),
        transaction[:amount],
        transaction[:notes]
      ]
    end
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
end
