require "httparty"
require "json"

class TransactionController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com/"
end
