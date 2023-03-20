require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_params) do
    {
      user: {
        username: 'drone'
      }
    }
  end

  describe 'GET #show' do
    context 'Authenticated user no profile' do
      before :each do
        login(user)
      end

      context 'with valid attributes' do
        it 'saves a new profile in the database' do
          expect { get :show, params: valid_params }.to change(Profile, :count).by(1)
        end
      end
    end

    context 'Authenticated user with profile' do
      let!(:profile) { create(:profile, user_id: user.id) }
      before :each do
        login(user)
      end

      context 'with valid attributes' do
        it 'saves a new profile in the database' do
          expect { get :show, params: valid_params }.to change(Profile, :count).by(0)
        end
      end
    end

    context 'Unauthenticated user' do
      it 'does not save a new drone in the database' do
        expect { get :show, params: { drone: attributes_for(:drone) } }
          .to_not change(Profile, :count)
      end
    end
  end

  describe 'GET #edit' do
    let!(:profile) { create(:profile, user_id: user.id) }

    context 'Authenticated user' do
      before { login(user) }
      before { get :edit, params: { user_id: user.id } }

      it 'check if the data is set to a variable @profile' do
        expect(assigns(:profile)).to eq profile
      end
    end

    context 'Unauthenticated user' do
      before { get :edit, params: { user_id: user.id } }

      it 'the drone does not change' do
        expect(assigns(:profile)).to_not eq profile
      end

      it 'redirect to sign in' do
        expect(assigns(:profile)).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    let!(:profile) { create(:profile, user_id: user.id) }

    context 'Authenticated user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'check if the data is set to a variable @profile in controller' do
          patch :update, params: { user_id: user.id, profile: attributes_for(:profile) }
          expect(assigns(:profile)).to eq profile
        end

        it 'change existing attributes' do
          patch :update, params: { user_id: user.id, profile: { name: 'New name profile' } }
          profile.reload

          expect(profile.name).to eq 'New name profile'
        end

        it 'redirect to update profile' do
          patch :update, params: { user_id: user.id, profile: attributes_for(:profile) }
          expect(response).to redirect_to profile
        end
      end

      context 'with invalid attributes' do
        it 'does not update profile' do
          patch :update, params: { user_id: user.id, profile: attributes_for(:profile, :invalid) }
          profile.reload

          expect(profile.name).to eq 'name'
        end
      end
    end

    context 'Unauthenticated user' do
      it 'does not update drone' do
        patch :update, params: { user_id: user.id, profile: { name: 'new name' } }
        profile.reload

        expect(profile.name).to eq profile.name
      end

      it 'redirect to sign in' do
        patch :update, params: { user_id: user.id, profile: attributes_for(:profile) }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
