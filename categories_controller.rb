require "httparty"
require "json"

class CategoriesController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com/"

  def self.index(token)
    options = {
      headers: { "Authorization" => "Token token=#{token}", "Content-Type" => "application/json" }
    }

    response = get("/categories", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.create(token, categorie_data)
    options = {
      headers: { "Content-Type" => "application/json", "Authorization" => "Token token=#{token}" },
      body: categorie_data.to_json
    }

    response = post("/categories", options)
    raise Net::HTTPError.new(response.parsed_response, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.add_to(token, category_id, new_categorie_data)
    options = {
      headers: { "Authorization" => "Token token=#{token}", "Content-Type" => "application/json" },
      body: new_categorie_data.to_json
    }

    response = post("/categories/#{category_id}/transactions", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.update(token, category_id, update_category_data)
    options = {
      headers: { "Authorization" => "Token token=#{token}", "Content-Type" => "application/json" },
      body: update_category_data.to_json
    }

    response = patch("/categories/#{category_id}", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.delete(token, category_id)
    options = {
      headers: { "Authorization" => "Token token=#{token}" }
    }

    response = delete("/categories/#{category_id}", options)
    p response
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true) if response.body
  end
end
