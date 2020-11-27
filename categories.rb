require_relative "categories_controller"

module Categories
  def load_categories
    @categories = CategoriesController.index(@user[:token])
  rescue Net::HTTPError => e
    e.response.parsed_response["errors"].each { |error| puts error }
    puts
  end

  def create_category
    categorie_data = categorie_form

    @categories.push(CategoriesController.create(@user[:token], categorie_data))
  rescue Net::HTTPError => e
    e.response.parsed_response["errors"].each { |error| puts error }
    puts
  end

  def toggle_category
    @toggle = !@toggle
  end

  def next_month
    @current_month = @current_month.next_month
  end

  def prev_month
    @current_month = @current_month.prev_month
  end
end
