require 'rails_helper'

RSpec.describe DronesController, type: :controller do
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
end
