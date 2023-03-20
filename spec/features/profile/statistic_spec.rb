require 'rails_helper'

feature 'User can see statistic in profile user' do
  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:profile) { create(:profile, user_id: user.id) }
  given(:category) { create(:category) }
  given!(:drone) { create(:drone, user: user, category: category) }
  given!(:comment) { create(:comment, drone: drone, user: user) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit profile_path
    end

    scenario 'see count drone profile if author' do
      within ".text-secondary.drone" do
        expect(page).to have_content(1)
      end
    end

    scenario 'see count comment profile if author' do
      within ".text-secondary.comment" do
        expect(page).to have_content(1)
      end
    end
  end

  describe 'Authenticated other user', js: true do
    background do
      sign_in(other_user)
      visit profile_path
    end

    scenario 'see count drone profile if author' do
      within ".text-secondary.drone" do
        expect(page).to have_content(1)
      end
    end

    scenario 'see count comment profile if author' do
      within ".text-secondary.comment" do
        expect(page).to have_content(1)
      end
    end
  end

  describe 'Unauthenticated user', js: true do
    background do
      visit profile_path
    end

    scenario 'see count drone profile if author' do
      within ".text-secondary.drone" do
        expect(page).to have_content(1)
      end
    end

    scenario 'see count comment profile if author' do
      within ".text-secondary.comment" do
        expect(page).to have_content(1)
      end
    end
  end
end
