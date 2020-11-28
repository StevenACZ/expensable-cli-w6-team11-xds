require_relative "categories_controller"

module Categories
  def load_categories
    @categories = CategoriesController.index(@user[:token])
  end

  def create_category
    category_data = category_form

    @categories.push(CategoriesController.create(@user[:token], category_data))
  end

  def add_to_category(category_id)
    new_categorie_data = new_categorie_form
    index = @categories.find_index { |category| category[:id] == category_id.to_i }
    @categories[index][:transactions].push(CategoriesController.add_to(@user[:token], category_id, new_categorie_data))
  end

  def update_category(category_id)
    update_category_data = update_category_form
    index = @categories.find_index { |category| category[:id] == category_id.to_i }

    updated_category = CategoriesController.update(@user[:token], category_id, update_category_data)
    @categories[index] = updated_category
  end

  def delete_category(category_id)
    index = @categories.find_index { |category| category[:id] == category_id.to_i }
    deleted_category = CategoriesController.destroy(@user[:token], category_id)
    if deleted_category
      @categories[index] = deleted_category
    else
      @categories.reject! { |category| category[:id] == category_id.to_i }
    end
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
