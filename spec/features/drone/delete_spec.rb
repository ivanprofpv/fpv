require 'rails_helper'

feature 'User can delete component in drone-card' do
  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:category) { create(:category) }
  given!(:drone) { create(:drone, user: user, category: category) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit drone_path(drone)
    end

    scenario 'delete drone if author' do
      expect(page).to have_content 'Delete build'
    end
  end

  describe 'Authenticated other user', js: true do
    background do
      sign_in(other_user)
      visit drone_path(drone)
    end

    scenario 'not see delete button component if not author' do

      within ".components" do
        expect(page).to_not have_content 'Delete build'
      end
    end
  end

  describe 'Unauthenticated user', js: true do
    background do
      visit drone_path(drone)
    end

    scenario 'can not see delete button' do

      expect(page).to_not have_content 'Delete build'
    end
  end
end
