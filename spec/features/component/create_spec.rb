require 'rails_helper'

feature 'User can add component for drone-card' do
  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:category) { create(:category) }
  given!(:component_category) { create(:component_category) }
  given!(:drone) { create(:drone, user: user, category: category) }
  given!(:other_drone) { create(:drone, user: other_user, category: category) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit drone_path(drone)
    end

    scenario 'add component to drone' do
      within ".components" do
        click_on 'Add component'

        select "title_category_component", :from => "component[component_category_id]"
        fill_in(id: 'component_title', with: 'name component')
        fill_in(id: 'component_url', with: 'https://ya.ru')
        fill_in(id: 'component_price', with: 10)

        click_on 'Create component'

        click_on 'Add component'

        select "title_category_component", :from => "component[component_category_id]"
        fill_in(id: 'component_title', with: 'name2 component2')
        fill_in(id: 'component_url', with: 'https://ya.ru')
        fill_in(id: 'component_price', with: 20)

        click_on 'Create component'
      end

      expect(page).to have_content('name component')
      expect(page).to have_content('click here')
      expect(page).to have_content(10)
      expect(page).to have_content('name2 component2')
      expect(page).to have_content('click here')
      expect(page).to have_content(20)
      expect(page).to have_content(30)
    end

    scenario 'add component with error' do
      within ".components" do
        click_on 'Add component'

        fill_in(id: 'component_title', with: '')
        fill_in(id: 'component_url', with: 'https://yaru')
        fill_in(id: 'component_price', with: 1000000)

        click_on 'Create component'
      end

      expect(page).to have_content("Component category must exist")
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Price Shorten the price to 5 characters")
      expect(page).to have_content("Url is invalid")
    end
  end

  scenario 'Authenticated user does not see the button if not the author', js: true do
    sign_in(user)
    visit drone_path(other_drone)

    expect(page).not_to have_content('Add component')
  end

  describe 'Unauthenticated user' do
    scenario 'do not add component' do
      visit drone_path(drone)

      expect(page).not_to have_content('Add component')
    end
  end
end
