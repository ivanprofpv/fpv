require 'rails_helper'

feature 'User can delete component in drone-card' do
  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:category) { create(:category) }
  given!(:drone) { create(:drone, user: user, category: category) }
  given!(:component_category) { create(:component_category) }
  given!(:component) { create(:component, drone_id: drone.id,
                              component_category_id: component_category.id) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit drone_path(drone)
    end

    scenario 'edit component if author' do
      within ".components" do

        click_on 'Edit'

        fill_in(id: 'component_title', with: 'new name component')

        click_on 'Update component'
      end

      expect(page).to have_content('new name component')
    end
  end

  describe 'Authenticated other user', js: true do
    background do
      sign_in(other_user)
      visit drone_path(drone)
    end

    scenario 'not see edit button component if not author' do

      within ".components" do
        expect(page).to_not have_content 'Edit'
      end
    end
  end

  describe 'Unauthenticated user', js: true do
    background do
      visit drone_path(drone)
    end

    scenario 'can not see edit button' do

      within ".components" do
        expect(page).to_not have_content 'Edit'
      end
    end
  end
end
