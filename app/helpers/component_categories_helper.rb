module ComponentCategoriesHelper
  def all_count_components_in_category(category)
    components = Component.where('component_category_id = ?', category)
    components.size
  end
end
