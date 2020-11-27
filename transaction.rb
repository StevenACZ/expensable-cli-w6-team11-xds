require_relative "transaction_controller"

module Transaction
  def load_transactions(category_id)
    @transactions = TransactionController.index(@user[:token], category_id)
  rescue Net::HTTPError => e
    e.response.parsed_response["errors"].each { |error| puts error }
    puts
  end

  def add_transaction(category_id)
    new_transaction_data = transaction_form

    @transactions.push(TransactionController.add(@user[:token], category_id, new_transaction_data))
  rescue Net::HTTPError => e
    e.response.parsed_response["errors"].each { |error| puts error }
    puts
  end
end
