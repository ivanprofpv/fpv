require 'rails_helper'

RSpec.describe ComponentCategoriesController, type: :controller do
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'Authenticated user can add component categories' do
      context 'with valid attributes' do
        before { login(user) }

        it 'save component categories' do
          expect do
            post :create, params: { component_category: attributes_for(:component_category) },
                                    format: :js
          end.to change(ComponentCategory, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        before { login(user) }

        it 'do not save component categories' do
          expect do
            post :create, params: { component_category: attributes_for(:component_category, :invalid) },
                                    format: :js
          end.not_to change(ComponentCategory, :count)
        end
      end
    end

    context 'Unauthenticated user can component categories' do
      it 'does not save component categories' do
        expect do
          post :create, params: { component_category: attributes_for(:component_category) },
                                  format: :js

        end.not_to change(ComponentCategory, :count)
      end
    end
  end

  describe 'PATCH #update' do

    let!(:component_category) { create(:component_category) }

    context 'authenticated user' do
      before { login(user) }
      context 'with valid attributes' do
        it 'changes component categories' do
          patch :update, params: { id: component_category, component_category: { title: 'new body' } }, format: :js
          component_category.reload
          expect(component_category.title).to eq 'new body'
        end
      end

      context 'with invalid attributes' do
        it 'does not changes component categories attributes' do
          expect do
            patch :update, params: { id: component_category, component_category: attributes_for(:component_category, :invalid) }, format: :js
          end.to_not change(component_category, :title)
        end
      end
    end

    context 'unauthenticated user' do
      context 'with valid attributes' do
        it 'does not change attributes' do
          expect do
            patch :update, params: { id: component_category, component_category: component_category }, format: :js
          end.to_not change(component_category, :title)
        end

        it 'redirect to sign in page' do
          patch :update, params: { id: component_category, component_category: component_category }
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'with invalid attributes' do
        it 'does not change attributes' do
          expect do
            patch :update, params: { id: component_category, component_category: attributes_for(:component_category, :invalid) }, format: :js
          end.to_not change(component_category, :title)
        end

        it 'redirect to sign in page' do
          patch :update, params: { id: component_category, component_category: attributes_for(:component_category, :invalid) }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'authenticated user' do
      before { login(user) }

      context 'component categories' do
        let!(:component_category) { create(:component_category) }

        it 'delete the component categoris' do
          expect { delete :destroy, params: { id: component_category }, format: :js }.to change(ComponentCategory, :count).by(-1)
        end
      end
    end

    context 'unauthenticated user' do
      let!(:component_category) { create(:component_category) }

      it 'unsuccessful attempt to delete component categories' do
        expect { delete :destroy, params: { id: component_category }, format: :js }.to_not change(ComponentCategory, :count)
      end

      it 'redirect to sign in' do
        delete :destroy, params: { id: component_category }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
