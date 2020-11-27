require "httparty"
require "json"

class TransactionController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com/"

  def self.index(token, id)
    options = {
      headers: { "Authorization" => "Token token=#{token}" }
    }

    response = get("/categories/#{id}/transactions", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end
end
