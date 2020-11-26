require "httparty"
require "json"

class CategoriesController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com/"

  def self.index(token)
    options = {
      headers: { "Authorization" => "Token token=#{token}", "Content-Type" => "application/json" },
    }

    response = get("/categories", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?
    JSON.parse(response.body, symbolize_names: true)
  end
end
