require 'rails_helper'

RSpec.describe DronesController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:user_admin) { create(:user, admin: 'true') }
  let(:category) { create(:category) }
  let(:drone) { create(:drone, user:, category:) }
  let(:valid_params) do
    {
      drone: {
        title: 'drone',
        category_id: category
      }
    }
  end

  describe 'GET #index' do
    let(:drones) { create_list(:drone, 3, category:, user:) }

    before { get :index }

    it 'fill the array with the created drone card objects' do
      expect(assigns(:drones)).to match_array(drones)
    end

    it 'render index views' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: drone } }

    it 'check if variable in controller matches' do
      expect(assigns(:drone)).to eq drone
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    context 'Authenticated user' do
      before :each do
        login(user)
        request.headers['accept'] = 'application/javascript'
      end

      context 'with valid attributes' do
        it 'saves a new drone in the database' do
          expect { post :create, params: valid_params }.to change(Drone, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'does not saves new drone-card in database' do
          expect do
            post :create, params: { drone: attributes_for(:drone, :invalid) }
          end.to_not change(Drone, :count)
        end
      end
    end

    context 'Unauthenticated user' do
      it 'does not save a new drone in the database' do
        expect { post :create, params: { drone: attributes_for(:drone) } }
          .to_not change(Drone, :count)
      end

      it 'redirect to sign in' do
        post :create, params: { drone: attributes_for(:drone) }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #edit' do
    context 'Authenticated user' do
      before { login(user) }
      before { get :edit, params: { id: drone, user: } }

      it 'check if the data is set to a variable @drone' do
        expect(assigns(:drone)).to eq drone
      end
    end

    context 'Unauthenticated user' do
      before { get :edit, params: { id: drone, user: } }

      it 'the drone does not change' do
        expect(assigns(:drone)).to_not eq drone
      end

      it 'redirect tosign in' do
        expect(assigns(:drone)).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    context 'Authenticated user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'check if the data is set to a variable @drone in controller' do
          patch :update, params: { id: drone, drone: attributes_for(:drone) }
          expect(assigns(:drone)).to eq drone
        end

        it 'change existing attributes' do
          patch :update, params: { id: drone, drone: { title: 'New name drone' } }
          drone.reload

          expect(drone.title).to eq 'New name drone'
        end

        it 'redirect to update drone-card' do
          patch :update, params: { id: drone, drone: attributes_for(:drone) }
          expect(response).to redirect_to drone
        end
      end

      context 'with invalid attributes' do
        it 'does not update drone-card' do
          patch :update, params: { id: drone, drone: attributes_for(:drone, :invalid) }
          drone.reload

          expect(drone.title).to eq 'TitleDrone'
        end
      end
    end

    context 'Authenticated admin user' do
      before { login(user_admin) }

      context 'with valid attributes' do
        it 'check if the data is set to a variable @drone in controller' do
          patch :update, params: { id: drone, drone: attributes_for(:drone) }
          expect(assigns(:drone)).to eq drone
        end

        it 'change existing attributes' do
          patch :update, params: { id: drone, drone: { title: 'New name drone' } }
          drone.reload

          expect(drone.title).to eq 'New name drone'
        end

        it 'redirect to update drone-card' do
          patch :update, params: { id: drone, drone: attributes_for(:drone) }
          expect(response).to redirect_to drone
        end
      end

      context 'with invalid attributes' do
        it 'does not update drone-card' do
          patch :update, params: { id: drone, drone: attributes_for(:drone, :invalid) }
          drone.reload

          expect(drone.title).to eq 'TitleDrone'
        end
      end
    end

    context 'Authenticated other user (not author)' do

      before { login(other_user) }

      it 'does not update drone' do
        patch :update, params: { id: drone, drone: { title: 'new title' } }
        drone.reload

        expect(drone.title).to eq drone.title
      end

      it 'redirect to sign in' do
        patch :update, params: { id: drone, drone: attributes_for(:drone) }
        
        expect(response).to redirect_to root_path
      end
    end

    context 'Unauthenticated user' do
      it 'does not update drone' do
        patch :update, params: { id: drone, drone: { title: 'new title' } }
        drone.reload

        expect(drone.title).to eq drone.title
      end

      it 'redirect to sign in' do
        patch :update, params: { id: drone, drone: attributes_for(:drone) }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'Authenticated admin user' do
      before { login(user_admin) }

      let!(:drone) { create(:drone, category:, user:) }

      it 'delete drone-card' do
        expect { delete :destroy, params: { id: drone } }.to change(Drone, :count).by(-1)
      end

      it 'redirect to home page' do
        delete :destroy, params: { id: drone }
        expect(response).to redirect_to root_path
      end
    end

    context 'Authenticated user' do
      before { login(user) }

      let!(:drone) { create(:drone, category:, user:) }

      it 'delete drone-card' do
        delete :destroy, params: { id: drone }
        expect(response).to redirect_to root_path
      end
    end

    context 'Unauthenticated user' do
      let!(:drone) { create(:drone, category:, user:) }

      it 'the question has not been deleted' do
        expect { delete :destroy, params: { id: drone } }.to_not change(Drone, :count)
      end

      it 'redirect to sign in' do
        delete :destroy, params: { id: drone }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
