module CategoriesHelper
  def count_drone_сategory(category)
    @count_сategory = Drone.where(category_id: category).all.count
  end
end
