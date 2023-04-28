require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { should have_many(:drones).dependent(:destroy) }

  it 'Authenticated user have one attached avatar to profile' do
    expect(user.avatar).to be_an_instance_of(ActiveStorage::Attached::One)
  end

  it 'validate avatar for profile' do
    user = build(:user, avatar: Rack::Test::UploadedFile.new("#{Rails.root}/spec/rails_helper.rb",  
                                                           'text/plain')) 
    expect(user).to_not be_valid

    user = build(:user, avatar: Rack::Test::UploadedFile.new("#{Rails.root}/public/avatar_default.png",  
                                                           'image/png'))
    expect(user).to be_valid 
  end
end