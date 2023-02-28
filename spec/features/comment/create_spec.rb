require 'rails_helper'

feature 'User can add comment for drone-card' do
  given(:user) { create(:user) }
  given(:category) { create(:category) }
  given!(:drone) { create(:drone, user: user, category: category) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit drone_path(drone)
    end

    scenario 'add comment to drone' do
      within "#new-comment" do
          fill_in(id: 'floatingTextarea', with: 'test comment')
          click_on 'Create comment'
      end

      expect(page).to have_content('test comment')
    end

    scenario 'add comment with error' do
      within "#new-comment" do
        click_on 'Create comment'
      end

      expect(page).to have_content("Body can't be blank")
    end
  end

  describe 'Unauthenticated user' do
    scenario 'do not add comment' do
      visit drone_path(drone)

      expect(page).not_to have_content('Create comment')
    end
  end
end