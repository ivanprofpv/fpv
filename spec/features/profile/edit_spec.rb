require 'rails_helper'

feature 'User can edit self profile' do
  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:profile) { create(:profile, user_id: user.id) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit profile_path
    end

    scenario 'edit profile if author' do
      within ".card-body" do

        click_on 'Edit Profile'

        fill_in(id: 'floatingTextareaName', with: 'new name profile')

        click_on 'Update'
      end

      expect(page).to have_content('new name profile')
    end

    scenario 'do not save (errors)' do
      within ".card-body" do

        click_on 'Edit Profile'

        fill_in(id: 'floatingTextareaName', with: '')

        click_on 'Update'
      end

      expect(page).to have_content("Profile was successfully updated.")
    end
  end

  describe 'Authenticated other user', js: true do
    background do
      sign_in(other_user)
      visit profile_path
    end

    scenario 'not see edit button component if not author' do

      within ".card-body" do
        expect(page).to_not have_content 'Edit Profile'
      end
    end
  end

  describe 'Unauthenticated user', js: true do
    background do
      visit profile_path
    end

    scenario 'can not see edit button' do

      within ".card-body" do
        expect(page).to_not have_content 'Edit Profile'
      end
    end
  end
end
