require 'rails_helper'

feature 'User can sees your profile' do
  given(:user) { create(:user) }
  given(:user_admin) { create(:user, admin: 'true') }
  given(:other_user) { create(:user) }
  given(:profile) { create(:profile, user_id: user.id) }
  given(:other_profile) { create(:profile, user_id: other_user.id) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit profile_path(profile)
    end

    scenario 'sees your profile if author' do
      expect(page).to have_content("name")
      expect(page).to have_content user.username
      expect(page).to have_content('Edit Profile')
    end
  end

  describe 'Authenticated other user', js: true do
    background do
      sign_in(other_user)
      visit profile_path(profile)
    end

    scenario 'sees your profile if author' do
      expect(page).to have_content("name")
      expect(page).to have_content user.username
      expect(page).to_not have_content('Edit Profile')
    end
  end

  describe 'Authenticated admin user', js: true do
    background do
      sign_in(user_admin)
      visit profile_path(profile)
    end

    scenario 'sees profile if admin' do
      expect(page).to have_content("name")
      expect(page).to have_content user.username
      expect(page).to have_content('Edit Profile')
    end
  end

  describe 'Unauthenticated user', js: true do
    background do
      sign_in(user)
      visit profile_path(other_profile)
    end

    scenario 'can not see edit button' do
      expect(page).to have_content("name")
      expect(page).to have_content other_user.username
      expect(page).to_not have_content('Edit Profile')
    end
  end
end
