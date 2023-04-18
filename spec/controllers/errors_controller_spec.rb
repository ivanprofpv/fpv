require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do

  describe 'GET #404' do
    before do
      get :not_found
    end

    it 'renders 404' do
      expect(response).to render_template :not_found
    end
  end

  describe 'GET #500' do
    before do
      get :internal_server
    end

    it 'renders 500' do
      expect(response).to render_template :internal_server
    end
  end

  describe 'GET #422' do
    before do
      get :unprocessable
    end

    it 'renders 422' do
      expect(response).to render_template :unprocessable
    end
  end
end
