require 'rails_helper'

RSpec.describe ComponentsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:category) { create(:category) }
  let(:component_category) { create(:component_category) }
  let(:drone) { create(:drone, user:, category:) }
  let(:drone_other_user) { create(:drone, user: other_user, category:) }

  describe 'PATCH #update' do
    let!(:component) do
      create(:component, drone_id: drone.id, component_category_id: component_category.id)
    end

    context 'authenticated user' do
      before { login(user) }
      context 'with valid attributes' do
        context "with user's component" do
          it 'changes component attributes' do
            patch :update,
                  params: { id: component, component: { title: 'new body', url: 'https://yandex.ru', price: '2' } }, format: :js
            component.reload
            expect(component.title).to eq 'new body'
            expect(component.url).to eq 'https://yandex.ru'
            expect(component.price).to eq 2
          end

          it 'renders update view' do
            patch :update,
                  params: { id: component, component: { title: 'new body', url: 'https://yandex.ru', price: '2' } }, format: :js
            expect(response).to render_template :update
          end
        end

        context "with other's component" do
          let!(:component) do
            create(:component, drone_id: drone_other_user.id,
                               component_category_id: component_category.id)
          end

          it 'not changes component attributes' do
            patch :update,
                  params: { id: component, component: { title: 'new body', url: 'https://yandex.ru', price: '2' } }, format: :js
            expect(component.title).to_not eq 'new body'
            expect(component.url).to_not eq 'https://yandex.ru'
            expect(component.price).to_not eq '2'
          end
        end
      end

      context 'with invalid attributes' do
        it 'does not changes component attributes' do
          expect do
            patch :update,
                  params: { id: component, component: attributes_for(:component, :invalid) }, format: :js
          end.to_not change(component, :title)
        end

        it 'renders update view' do
          patch :update,
                params: { id: component, component: attributes_for(:component, :invalid) }, format: :js
          expect(response).to render_template :update
        end
      end
    end

    context 'unauthenticated user' do
      context 'with valid attributes' do
        it 'does not change attributes' do
          expect do
            patch :update, params: { id: component, component: }, format: :js
          end.to_not change(component, :title)
        end

        it 'redirect to sign in page' do
          patch :update, params: { id: component, component: }
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'with invalid attributes' do
        it 'does not change attributes' do
          expect do
            patch :update,
                  params: { id: component, component: attributes_for(:component, :invalid) }, format: :js
          end.to_not change(component, :title)
        end

        it 'redirect to sign in page' do
          patch :update, params: { id: component, component: attributes_for(:component, :invalid) }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'authenticated user' do
      before { login(user) }

      context 'component that the user created' do
        let!(:component) do
          create(:component, drone_id: drone.id, component_category_id: component_category.id)
        end

        it 'delete the component' do
          expect do
            delete :destroy, params: { id: component }, format: :js
          end.to change(Component, :count).by(-1)
        end
      end
    end

    context 'unauthenticated user' do
      let!(:component) do
        create(:component, drone_id: drone.id, component_category_id: component_category.id)
      end

      it 'unsuccessful attempt to delete someone another component' do
        expect do
          delete :destroy, params: { id: component }, format: :js
        end.to_not change(Component, :count)
      end

      it 'redirect to sign in' do
        delete :destroy, params: { id: component }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
