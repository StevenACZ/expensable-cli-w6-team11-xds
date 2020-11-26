require_relative "categories_controller"

module Categories
  def load_categories
    @categories = CategoriesController.index(@user[:token])
  rescue Net::HTTPError => e
    e.response.parsed_response["errors"].each { |error| puts error }
    puts
  end
end
