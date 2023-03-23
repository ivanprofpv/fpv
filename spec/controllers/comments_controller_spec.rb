require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:user_admin) { create(:user, admin: 'true') }
  let(:category) { create(:category) }
  let(:drone) { create(:drone, user:, category:) }

  describe 'POST #create' do
    context 'Authenticated user can add comment' do
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
    end

    context 'Unauthenticated user can add comment' do
      it 'does not save drone comment' do
        expect do
          post :create, params: { drone_id: drone, user_id: user,
                                  comment: attributes_for(:comment) },
                        format: :js
        end.not_to change(Comment, :count)
      end
    end
  end

  describe 'PATCH #update' do
    let(:comment) { create(:comment, drone_id: drone.id, user_id: user.id) }

    context 'authenticated admin user' do
      before { login(user_admin) }
      context 'with valid attributes' do
        context "with user's comment" do
          it 'changes comment attributes' do
            patch :update, params: { id: comment, comment: { body: 'new body' } }, format: :js
            comment.reload
            expect(comment.body).to eq 'new body'
          end

          it 'renders update view' do
            patch :update, params: { id: comment, comment: { body: 'new body' } }, format: :js
            expect(response).to render_template :update
          end

          it "is comment user's" do
            patch :update, params: { id: comment, comment: { body: 'new body' } }, format: :js
            expect(assigns(:comment).user).to eq user
          end
        end

        context "with other's comment" do
          let!(:comment) { create(:comment, drone_id: drone.id, user_id: other_user.id) }

          it 'not changes comment attributes' do
            patch :update, params: { id: comment, comment: { body: 'new body' } }, format: :js
            expect(comment.body).to_not eq 'new body'
            expect(assigns(:comment).user).to_not eq user
          end
        end
      end

      context 'with invalid attributes' do
        it 'does not changes comment attributes' do
          expect do
            patch :update, params: { id: comment, comment: attributes_for(:comment, :invalid) },
                           format: :js
          end.to_not change(comment, :body)
        end

        it 'renders update view' do
          patch :update, params: { id: comment, comment: attributes_for(:comment, :invalid) },
                         format: :js
          expect(response).to render_template :update
        end
      end
    end

    context 'authenticated user' do
      before { login(user) }
      context 'with valid attributes' do
        context "with user's comment" do
          it 'changes comment attributes' do
            patch :update, params: { id: comment, comment: { body: 'new body' } }, format: :js
            comment.reload
            expect(comment.body).to eq 'new body'
          end

          it 'renders update view' do
            patch :update, params: { id: comment, comment: { body: 'new body' } }, format: :js
            expect(response).to render_template :update
          end

          it "is comment user's" do
            patch :update, params: { id: comment, comment: { body: 'new body' } }, format: :js
            expect(assigns(:comment).user).to eq user
          end
        end

        context "with other's comment" do
          let!(:comment) { create(:comment, drone_id: drone.id, user_id: other_user.id) }

          it 'not changes comment attributes' do
            patch :update, params: { id: comment, comment: { body: 'new body' } }, format: :js
            expect(comment.body).to_not eq 'new body'
            expect(assigns(:comment).user).to_not eq user
          end
        end
      end

      context 'with invalid attributes' do
        it 'does not changes comment attributes' do
          expect do
            patch :update, params: { id: comment, comment: attributes_for(:comment, :invalid) },
                           format: :js
          end.to_not change(comment, :body)
        end

        it 'renders update view' do
          patch :update, params: { id: comment, comment: attributes_for(:comment, :invalid) },
                         format: :js
          expect(response).to render_template :update
        end
      end
    end

    context 'unauthenticated user' do
      context 'with valid attributes' do
        it 'does not change attributes' do
          expect do
            patch :update, params: { id: comment, comment: }, format: :js
          end.to_not change(comment, :body)
        end

        it 'redirect to sign in page' do
          patch :update, params: { id: comment, comment: }
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'with invalid attributes' do
        it 'does not change attributes' do
          expect do
            patch :update, params: { id: comment, comment: attributes_for(:comment, :invalid) },
                           format: :js
          end.to_not change(comment, :body)
        end

        it 'redirect to sign in page' do
          patch :update, params: { id: comment, comment: attributes_for(:comment, :invalid) }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'authenticated user' do
      before { login(user) }

      context 'comment that the user created' do
        let!(:comment) { create(:comment, drone_id: drone.id, user_id: user.id) }

        it 'delete the comment' do
          expect do
            delete :destroy, params: { id: comment }, format: :js
          end.to change(Comment, :count).by(-1)
        end
      end

      context 'comment that the user did not create' do
        let!(:comment) { create(:comment, drone_id: drone.id, user_id: other_user.id) }

        it 'unsuccessful attempt to delete someone another comment' do
          expect do
            delete :destroy, params: { id: comment }, format: :js
          end.to_not change(Comment, :count)
        end
      end
    end

    context 'authenticated admin user' do
      before { login(user_admin) }

      context 'comment that the user created' do
        let!(:comment) { create(:comment, drone_id: drone.id, user_id: user.id) }

        it 'delete the comment' do
          expect do
            delete :destroy, params: { id: comment }, format: :js
          end.to change(Comment, :count).by(-1)
        end
      end

      context 'comment that the admin did not create' do
        let!(:comment) { create(:comment, drone_id: drone.id, user_id: other_user.id) }

        it 'unsuccessful attempt to delete someone another comment' do
          expect do
            delete :destroy, params: { id: comment }, format: :js
          end.to change(Comment, :count).by(-1)
        end
      end
    end

    context 'authenticated other user' do
      before { login(other_user) }

      context 'comment that the user created' do
        let!(:comment) { create(:comment, drone_id: drone.id, user_id: user.id) }

        it 'do not delete the comment' do
          expect do
            delete :destroy, params: { id: comment }, format: :js
          end.to_not change(Comment, :count)
        end
      end
    end

    context 'unauthenticated user' do
      let!(:comment) { create(:comment, drone_id: drone.id, user_id: user.id) }

      it 'unsuccessful attempt to delete someone another comment' do
        expect do
          delete :destroy, params: { id: comment }, format: :js
        end.to_not change(Comment, :count)
      end

      it 'redirect to sign in' do
        delete :destroy, params: { id: comment }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
