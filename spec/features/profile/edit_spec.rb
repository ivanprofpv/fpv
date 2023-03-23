require 'rails_helper'

feature 'User can edit self profile' do
  given(:user) { create(:user) }
  given(:user_admin) { create(:user, admin: 'true') }
  given(:other_user) { create(:user) }
  given(:profile) { create(:profile, user_id: user.id) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit profile_path(profile)
    end

    scenario 'edit profile if author' do
      click_on 'Edit Profile'

      fill_in 'Name', with: 'new name profile'

      click_on 'Update'

      expect(page).to have_content('new name profile')
    end

    scenario 'save profile nil name' do
      click_on 'Edit Profile'

      fill_in(id: 'floatingTextareaName', with: '')

      click_on 'Update'

      expect(page).to have_content("Profile was successfully updated.")
    end
  end

  describe 'Authenticated admin user', js: true do
    background do
      sign_in(user_admin)
      visit profile_path(profile)
    end

    scenario 'edit profile if author' do
      click_on 'Edit Profile'

      fill_in 'Name', with: 'new name2 profile'

      click_on 'Update'

      expect(page).to have_content('new name2 profile')
    end
  end

  describe 'Authenticated other user', js: true do
    background do
      sign_in(other_user)
      visit profile_path(profile)
    end

    scenario 'do not edit profile if not author' do
      expect(page).to_not have_content('Edit Profile')
    end
  end

  describe 'Unauthenticated user', js: true do
    background do
      visit profile_path(profile)
    end

    scenario 'can not see edit button' do
      expect(page).to_not have_content 'Edit Profile'
    end
  end
end
