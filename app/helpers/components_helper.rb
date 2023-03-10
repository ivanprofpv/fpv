module ComponentsHelper
  def calculate_price
    @price = Component.where(drone_id: @drone).pluck(:price)
    @price.sum { |e| e.to_i }
  end
end
