require "httparty"
require "json"

class TransactionController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com/"

  def self.index(token, category_id)
    options = {
      headers: { "Authorization" => "Token token=#{token}" }
    }

    response = get("/categories/#{category_id}/transactions", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.add(token, category_id, new_transaction_data)
    options = {
      headers: { "Authorization" => "Token token=#{token}", "Content-Type" => "application/json" },
      body: new_transaction_data.to_json
    }

    response = post("/categories/#{category_id}/transactions", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end
end
