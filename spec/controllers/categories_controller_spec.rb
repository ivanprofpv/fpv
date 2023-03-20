require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }

  describe 'GET #index' do
    let(:categories) { create_list(:category, 3) }

    before { get :index }

    it 'fill the array with the created category objects' do
      expect(assigns(:categories)).to match_array(categories)
    end

    it 'render index views' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: category } }

    it 'check if variable in controller matches' do
      expect(assigns(:category)).to eq category
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'check if the data is set to a variable @category' do
      expect(assigns(:category)).to be_a_new(Category)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'Authenticated user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'saves new category in database' do
          expect do
            post :create, params: { category: attributes_for(:category) }
          end.to change(Category, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'does not saves new category-card in database' do
          expect do
            post :create,
                 params: { category: attributes_for(:category, :invalid) }
          end.to_not change(Category, :count)
        end
      end
    end

    context 'Unauthenticated user' do
      context 'with valid attributes' do
        it 'saves new category in database' do
          expect do
            post :create, params: { category: attributes_for(:category) }
          end.to change(Category, :count).by(0)
        end
      end
    end
  end

  describe 'GET #edit' do
    before { login(user) }
    before { get :edit, params: { id: category } }

    it 'check if the data is set to a variable @category' do
      expect(assigns(:category)).to eq category
    end
  end

  describe 'PATCH #update' do
    context 'Authenticated user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'check if the data is set to a variable @category in controller' do
          patch :update, params: { id: category, category: attributes_for(:category) }
          expect(assigns(:category)).to eq category
        end

        it 'change existing attributes' do
          patch :update, params: { id: category, category: { title: 'New name category' } }
          category.reload

          expect(category.title).to eq 'New name category'
        end

        it 'redirect to update category' do
          patch :update, params: { id: category, category: attributes_for(:category) }
          expect(response).to redirect_to category
        end
      end

      context 'with invalid attributes' do
        it 'does not update category' do
          patch :update, params: { id: category, category: attributes_for(:category, :invalid) }
          category.reload

          expect(category.title).to eq 'DroneCategory'
        end
      end
    end

    context 'Unauthenticated user' do
      it 'does not update drone' do
        patch :update, params: { id: category, category: { title: 'New name category' } }
        category.reload

        expect(category.title).to eq category.title
      end

      it 'redirect to sign in' do
        patch :update, params: { id: category, category: attributes_for(:category) }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'Authenticated user' do
      before { login(user) }

      let!(:category) { create(:category) }

      it 'delete category' do
        expect { delete :destroy, params: { id: category } }.to change(Category, :count).by(-1)
      end

      it 'redirect to home page' do
        delete :destroy, params: { id: category }
        expect(response).to redirect_to root_path
      end
    end

    context 'Unauthenticated user' do
      let!(:category) { create(:category) }

      it 'delete category' do
        expect { delete :destroy, params: { id: category } }.to change(Category, :count).by(0)
      end

      it 'redirect to home page' do
        delete :destroy, params: { id: category }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
