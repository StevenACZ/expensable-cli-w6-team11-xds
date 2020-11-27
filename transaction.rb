require_relative "transaction_controller"

module Transaction
  def load_transactions(category_id)
    @transactions = TransactionController.index(@user[:token], category_id)
  end

  def add_transaction(category_id)
    new_transaction_data = transaction_form

    @transactions.push(TransactionController.add(@user[:token], category_id, new_transaction_data))
  end

  def update_transaction(category_id, id)
    index = @transactions.find_index { |transaction| transaction[:id] == id.to_i }
    new_transaction_data = transaction_form

    updated_transaction = TransactionController.update(@user[:token], category_id, new_transaction_data, id)
    @transactions[index] = updated_transaction
  end

  def delete_transaction(category_id, id)
    index = @transactions.find_index { |transaction| transaction[:id] == id.to_i }

    delete_transaction = TransactionController.destroy(@user[:token], category_id, id)
    if delete_transaction
      @transactions[index] = delete_transaction
    else
      @transactions.reject! { |transaction| transaction[:id] == id.to_i }
    end
  end
end
