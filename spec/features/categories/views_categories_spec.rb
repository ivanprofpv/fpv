require 'rails_helper'

feature 'User can sees your profile' do
  given(:user) { create(:user) }
  given(:user_admin) { create(:user, admin: 'true') }
  given!(:category) { create(:category) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit categories_path
    end

    scenario 'sees category' do
      expect(page).to have_content("DroneCategory")
    end
  end

  describe 'Authenticated admin user', js: true do
    background do
      sign_in(user_admin)
      visit categories_path
    end

    scenario 'sees category' do
      expect(page).to have_content("DroneCategory")
    end
  end

  describe 'Unauthenticated user', js: true do
    background do
      visit categories_path
    end

    scenario 'sees category' do
      expect(page).to have_content("DroneCategory")
    end
  end
end
