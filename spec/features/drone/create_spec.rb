require 'rails_helper'

feature 'User can create drone-card' do

  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit root_path
      click_on 'Build drone'
    end

    scenario 'create drone-card' do
      fill_in 'Title', with: 'Test name drone'
      fill_in 'Body', with: 'Test body'
      click_on 'Build'

      expect(page).to have_content 'Drone created successfully.'
      expect(page).to have_content 'Test name drone'
      expect(page).to have_content 'Test body'
    end

    scenario 'create drone-card with attached foto' do
      fill_in 'Title', with: 'Test name drone'
      fill_in 'Body', with: 'Test body'

      attach_file 'File', ["#{Rails.root}/spec/support/drone.jpg", "#{Rails.root}/spec/support/drone2.jpg"]
      click_on 'Build'

      expect(page).to have_link 'drone.jpg'
      expect(page).to have_link 'drone2.jpg'
    end
  end
end
