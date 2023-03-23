require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:user_admin) { create(:user, admin: 'true') }
  let(:profile) { create(:profile, user_id: user.id) }
  let(:other_profile) { create(:profile, user_id: other_user.id) }


  describe 'GET #show' do
    context 'Authenticated user' do
      before :each do
        login(user)
      end

      it 'the user has access to his profile' do
        get :show, params: { id: profile }
        expect(assigns(:profile).user).to eq user
      end

      it "user can view another user's profile" do
        get :show, params: { id: other_profile }
        expect(assigns(:profile).user).to eq other_user
      end
    end

    context 'Authenticated admin user' do
      before :each do
        login(user_admin)
      end

      it 'the user has access to his profile' do
        get :show, params: { id: profile }
        expect(assigns(:profile).user).to eq user
      end

      it "user can view another user's profile" do
        get :show, params: { id: other_profile }
        expect(assigns(:profile).user).to eq other_user
      end
    end

    context 'Unauthenticated user' do
      it 'does not save a new profile in the database' do
        get :show, params: { id: profile }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #edit' do
    let!(:profile) { create(:profile, user_id: user.id) }
    before { get :edit, params: { id: profile } }

    context 'Authenticated user' do
      before { login(user) }
      before { get :edit, params: { id: profile } }

      it 'check if the data is set to a variable @profile' do
        expect(assigns(:profile)).to eq profile
      end
    end

    context 'Authenticated admin user' do
      before { login(user_admin) }
      before { get :edit, params: { id: profile } }

      it 'check if the data is set to a variable @profile' do
        expect(assigns(:profile)).to eq profile
      end
    end

    context 'Unauthenticated user' do
      before { get :edit, params: { id: profile } }

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
          patch :update, params: { id: profile, profile: { name: 'new name' } }, format: :js
          profile.reload
          expect(profile.name).to eq 'new name'
        end

        it 'redirect to update profile' do
          patch :update, params: { id: profile, profile: attributes_for(:profile) }
          expect(response).to redirect_to profile
        end
      end

      context 'with invalid attributes' do
        it 'does not update profile' do
          patch :update, params: { id: profile, profile: attributes_for(:profile, :invalid) }
          profile.reload

          expect(profile.name).to eq 'name'
        end
      end
    end

    context 'Authenticated admin user' do
      before { login(user_admin) }

      context 'with valid attributes' do
        it 'check if the data is set to a variable @profile in controller' do
          patch :update, params: { id: profile, profile: { name: 'new name2' } }, format: :js
          profile.reload
          expect(profile.name).to eq 'new name2'
        end

        it 'redirect to update profile' do
          patch :update, params: { id: profile, profile: attributes_for(:profile) }
          expect(response).to redirect_to profile
        end
      end

      context 'with invalid attributes' do
        it 'does not update profile' do
          patch :update, params: { id: profile, profile: attributes_for(:profile, :invalid) }
          profile.reload

          expect(profile.name).to eq 'name'
        end
      end
    end

    context 'Unauthenticated user' do
      it 'does not update drone' do
        patch :update, params: { id: profile, profile: { name: 'new name' } }
        profile.reload

        expect(profile.name).to eq profile.name
      end

      it 'redirect to sign in' do
        patch :update, params: { id: profile, profile: attributes_for(:profile) }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
