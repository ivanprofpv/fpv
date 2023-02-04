require 'rails_helper'

feature 'user can see a list of all drones' do
  given(:user) { create(:user) }
  given!(:drone) { create_list(:drone, 2, user: user) }

  scenario 'authenticated user can see a list of all drones' do
    sign_in(user)
    visit root_path

    expect(page).to have_content drone[0].title
    expect(page).to have_content drone[1].title
  end

  scenario 'unauthenticated user can see a list of all drones' do
    visit root_path

    expect(page).to have_content drone[0].title
    expect(page).to have_content drone[1].title
  end
end
