ComponentCategory.destroy_all

pc = ComponentCategory.create!(title: "Flight controller")
esc = ComponentCategory.create!(title: "ESC")
camera = ComponentCategory.create!(title: "Camera")

Category.destroy_all

tiny = Category.create!(title: "TinyWhoop")
cine = Category.create!(title: "CineWhoop")

Drone.destroy_all

drone = Drone.create!(title: "Test drone", category_id: 1, user_id: 1)

Component.destroy_all

pc2 = Component.create!(title: "Flight controller", price: 25, drone_id: 1, component_category_id: 2)
