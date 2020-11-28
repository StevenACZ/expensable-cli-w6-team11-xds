require "minitest/autorun"
require_relative "expensable"

class ExpensableTest < Minitest::Test
  # test if a acount electronic could be create arguments
  def test_if_acount_electronic_is_create_without_argumts
    p expensable = Expensable.new
    p assert_instance_of Expensable, expensable
    # p assert !expensable.nil?
  end

  #test default values when created without argumets
  def test_deffault_values
    expensable = Expensable.new
    # assert_equal 10, coffee_machine.capacities[:coffee]
    assert_equal nil, expensable.user
    assert_equal nil, expensable.categories
    assert_equal false, expensable.toggle
    assert_equal Date, expensable.current_month.class
    assert_equal nil, expensable.transactions
  end
end
