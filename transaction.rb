require_relative "transaction_controller"

module Transaction
  def load_transactions(id)
    @transactions = TransactionController.index(@user[:token], id)
  rescue Net::HTTPError => e
    e.response.parsed_response["errors"].each { |error| puts error }
    puts
  end
end
