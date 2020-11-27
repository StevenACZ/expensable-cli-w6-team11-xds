require_relative "transaction_controller"

module Transaction
  def load_transactions(category_id)
    @transactions = TransactionController.index(@user[:token], category_id)
  end
end
