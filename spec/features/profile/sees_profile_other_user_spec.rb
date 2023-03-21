require 'rails_helper'

feature 'User can sees your profile' do
  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:profile) { create(:profile, user_id: user.id) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit profile_path
    end

    scenario 'sees your profile if author' do
      expect(page).to have_content("name")
      expect(page).to have_content user.username
    end
  end

  describe 'Authenticated other user', js: true do
    background do
      sign_in(other_user)
      visit profile_path
    end

    scenario 'sees your profile if author' do
      expect(page).to have_content("name")
      expect(page).to have_content user.username
      expect(page).to_not have_content('Edit Profile')
    end
  end

  describe 'Unauthenticated user', js: true do
    background do
      visit profile_path
    end

    scenario 'can not see edit button' do
      expect(page).to have_content("name")
      expect(page).to have_content user.username
      expect(page).to_not have_content('Edit Profile')
    end
  end
end
