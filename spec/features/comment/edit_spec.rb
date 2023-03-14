require 'rails_helper'

feature 'User can delete component in drone-card' do
  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:category) { create(:category) }
  given!(:drone) { create(:drone, user: user, category: category) }
  given!(:comment) { create(:comment, drone: drone, user: user) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit drone_path(drone)
    end

    scenario 'edit comment if author' do
      within "#comments" do

        click_on 'Edit'

        fill_in(id: 'floatingTextarea', with: 'new name comment')

        click_on 'Update comment'
      end

      expect(page).to have_content('new name comment')
    end

    scenario 'do not save (errors)' do
      within "#comments" do

        click_on 'Edit'

        fill_in(id: 'floatingTextarea', with: '')

        click_on 'Update comment'
      end

      expect(page).to have_content("Body can't be blank")
    end
  end

  describe 'Authenticated other user', js: true do
    background do
      sign_in(other_user)
      visit drone_path(drone)
    end

    scenario 'not see edit button component if not author' do

      within "#comments" do
        expect(page).to_not have_content 'Edit'
      end
    end
  end

  describe 'Unauthenticated user', js: true do
    background do
      visit drone_path(drone)
    end

    scenario 'can not see edit button' do

      within "#comments" do
        expect(page).to_not have_content 'Edit'
      end
    end
  end
end
