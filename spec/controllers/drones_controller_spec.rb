require 'rails_helper'

RSpec.describe DronesController, type: :controller do
  let(:drone) { create(:drone) }

  describe 'GET #index' do
    let(:drones) { create_list(:drone, 3) }

    before { get :index }

    it 'fill the array with the created drone card objects' do
      expect(assigns(:drones)).to match_array(drones)
    end

    it 'render index views' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do

  end

  describe 'GET #create' do
    context 'with valid attributes' do
    end

    context 'with invalid attributes' do
    end
  end

  describe 'GET #edit' do

  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
    end

    context 'with invalid attributes' do
    end
  end

  describe 'DELETE #destroy' do

  end

end
