require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let!(:drone) { create(:drone, title: 'test', user:, category:) }

  describe 'GET #index' do
      before do
        get :index, params: { query: 'test' }
      end

      it 'assigns @search_result' do
        expect(assigns(:search_result)).to eq([drone])
      end

      it 'renders index' do
        expect(response).to render_template :index
      end
    end
end
