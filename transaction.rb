require_relative "transaction_controller"

module Transaction
  def load_transactions(category_id)
    @transactions = TransactionController.index(@user[:token], category_id)
  end

  def add_transaction(category_id)
    new_transaction_data = transaction_form

    @transactions.push(TransactionController.add(@user[:token], category_id, new_transaction_data))
  end
end
