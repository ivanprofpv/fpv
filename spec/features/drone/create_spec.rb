require 'rails_helper'

feature 'User can create drone-card' do

  given(:user) { create(:user) }
  given!(:category) { create(:category) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit root_path
      within '.navbar-nav' do
        click_on 'Create drone build'
      end
    end

    scenario 'create drone-card' do
      fill_in 'Title', with: 'Test name drone'
      fill_in 'Body', with: 'Test body'
      select ('DroneCategory'), from: 'drone_category_id'
      click_on 'Build'

      expect(page).to have_content 'Drone created successfully.'
      expect(page).to have_content 'Test name drone'
    end
  end
end
