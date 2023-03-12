require 'rails_helper'

RSpec.describe ComponentsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:category) { create(:category) }
  let(:component_category) { create(:component_category) }
  let(:drone) { create(:drone, user: user, category: category) }
  let(:drone_other_user) { create(:drone, user: other_user, category: category) }
  let(:valid_params) do
        {  drone_id: drone.id, component_category_id: component_category.id,
           component: {
            title: "drone",
            url: "",
            price: 1
          }
        }
      end

  describe 'POST #create' do
    context 'Authenticated user can add component' do
      context 'with valid attributes' do
        before { login(user) }

        it 'save drone component' do
          expect { post :create, params: valid_params }.to change(Component, :count).by(1)
        end


        it 'render create' do
          post :create, params: { drone_id: drone,
                                  component: attributes_for(:component) },
                                  format: :js

          expect(response).to render_template :create
        end
      end

      context 'with invalid attributes' do
        before { login(user) }

        it 'do not save drone component' do
          expect do
            post :create, params: { drone_id: drone,
                                    component: attributes_for(:component, :invalid) },
                                    format: :js
          end.not_to change(Component, :count)
        end

        it 'render create' do
          post :create, params: { drone_id: drone,
                                  component: attributes_for(:component, :invalid) },
                                  format: :js

          expect(response).to render_template :create
        end
      end
    end

    context 'Unauthenticated user can add component' do
      it 'does not save drone component' do
        expect do
          post :create, params: { drone_id: drone,
                                  component: attributes_for(:component) },
                                  format: :js
        end.not_to change(Component, :count)
      end
    end
  end

  describe 'PATCH #update' do

    let!(:component) { create(:component, drone_id: drone.id, component_category_id: component_category.id) }

    context 'authenticated user' do
      before { login(user) }
      context 'with valid attributes' do
        context "with user's component" do
          it 'changes component attributes' do
            patch :update, params: { id: component, component: { title: 'new body', url: 'https://yandex.ru', price: '2' } }, format: :js
            component.reload
            expect(component.title).to eq 'new body'
            expect(component.url).to eq 'https://yandex.ru'
            expect(component.price).to eq 2
          end

          it 'renders update view' do
            patch :update, params: { id: component, component: { title: 'new body', url: 'https://yandex.ru', price: '2' } }, format: :js
            expect(response).to render_template :update
          end
        end

        context "with other's component" do
          let!(:component) { create(:component, drone_id: drone_other_user.id, component_category_id: component_category.id) }

          it 'not changes component attributes' do
            patch :update, params: { id: component, component: { title: 'new body', url: 'https://yandex.ru', price: '2' } }, format: :js
            expect(component.title).to_not eq 'new body'
            expect(component.url).to_not eq 'https://yandex.ru'
            expect(component.price).to_not eq '2'
          end
        end
      end

      context 'with invalid attributes' do
        it 'does not changes component attributes' do
          expect do
            patch :update, params: { id: component, component: attributes_for(:component, :invalid) }, format: :js
          end.to_not change(component, :title)
        end

        it 'renders update view' do
          patch :update, params: { id: component, component: attributes_for(:component, :invalid) }, format: :js
          expect(response).to render_template :update
        end
      end
    end

    context 'unauthenticated user' do
      context 'with valid attributes' do
        it 'does not change attributes' do
          expect do
            patch :update, params: { id: component, component: component }, format: :js
          end.to_not change(component, :title)
        end

        it 'redirect to sign in page' do
          patch :update, params: { id: component, component: component }
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'with invalid attributes' do
        it 'does not change attributes' do
          expect do
            patch :update, params: { id: component, component: attributes_for(:component, :invalid) }, format: :js
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
        let!(:component) { create(:component, drone_id: drone.id, component_category_id: component_category.id) }

        it 'delete the component' do
          expect { delete :destroy, params: { id: component }, format: :js }.to change(Component, :count).by(-1)
        end
      end
    end

    context 'unauthenticated user' do
      let!(:component) { create(:component, drone_id: drone.id, component_category_id: component_category.id) }

      it 'unsuccessful attempt to delete someone another component' do
        expect { delete :destroy, params: { id: component }, format: :js }.to_not change(Component, :count)
      end

      it 'redirect to sign in' do
        delete :destroy, params: { id: component }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
