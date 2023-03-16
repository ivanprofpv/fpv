require 'rails_helper'

feature 'User can create drone-card' do

  given(:user) { create(:user) }
  given!(:category) { create(:category) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit new_drone_path
    end

    scenario 'create drone-card' do
      fill_in 'Title', with: 'Test name drone'
      select ('DroneCategory'), from: 'drone_category_id'
      click_on 'Build'

      expect(page).to have_content 'Drone created successfully.'
      expect(page).to have_content 'Test name drone'
    end

    scenario 'can not create drone-card (error title and category)', js: true do
      fill_in 'Title', with: ''
      click_on 'Build'

      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Category must exist"
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Can not created drone' do
      visit root_path

      within '.container' do
        click_on 'Create drone build'
      end

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
