ComponentCategory.destroy_all

pc = ComponentCategory.create!(title: "Flight controller")
esc = ComponentCategory.create!(title: "ESC")
camera = ComponentCategory.create!(title: "Camera")

Category.destroy_all

tiny = Category.create!(title: "TinyWhoop")
cine = Category.create!(title: "CineWhoop")
