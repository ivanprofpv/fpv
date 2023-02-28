require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:drone) { create(:drone, user: user, category: category) }

  describe 'POST #create' do
    context 'with valid attributes' do
      before { login(user) }

      it 'save drone comment' do
        expect do
          post :create, params: { drone_id: drone, user_id: user,
                                  comment: attributes_for(:comment) },
                                  format: :js
        end.to change(Comment, :count).by(1)
      end

      it 'render create' do
        post :create, params: { drone_id: drone, user_id: user,
                                comment: attributes_for(:comment) },
                                format: :js

        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      before { login(user) }

      it 'do not save drone comment' do
        expect do
          post :create, params: { drone_id: drone, user_id: user,
                                  comment: attributes_for(:comment, :invalid) },
                                  format: :js
        end.not_to change(Comment, :count)
      end

      it 'render create' do
        post :create, params: { drone_id: drone, user_id: user,
                                comment: attributes_for(:comment, :invalid) },
                                format: :js

        expect(response).to render_template :create
      end
    end

    context 'unauthenticated user can add comment' do
      it 'does not save drone comment' do
        expect do
          post :create, params: { drone_id: drone, user_id: user,
                                  comment: attributes_for(:comment) },
                                  format: :js

        end.not_to change(Comment, :count)
      end
    end
  end
end
