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

    scenario 'vote comment if author' do
      within ".likes-comment" do
        Capybara.page.find('.fa-regular').click
        expect(page).to have_content('1')
      end
    end
  end

  describe 'Authenticated other user', js: true do
    background do
      sign_in(other_user)
      visit drone_path(drone)
    end

    scenario 'vote comment if not author' do
      within ".likes-comment" do
        Capybara.page.find('.fa-regular').click

        expect(page).to have_content('1')
      end
    end

    scenario 'unvote comment' do
      within ".likes-comment" do
        Capybara.page.find('.fa-regular').click
        Capybara.page.find('.fa-solid').click

        expect(page).to have_content('0')
      end
    end
  end

  describe 'Unauthenticated user', js: true do
    background do
      visit drone_path(drone)
    end

    scenario 'redirect to login' do

      within ".likes-comment" do
        Capybara.page.find('.fa-regular').click

        expect(current_path).to eq('/users/login')
      end
    end
  end
end
