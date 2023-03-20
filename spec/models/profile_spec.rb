require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:user) { create(:user) }

  it { should belong_to :user }

  it 'validates name length' do
    FactoryBot.build(:profile, user_id: user.id, name: "12345678901234567890
                                                      12345678901234567890
                                                      123456789012345678901").should_not be_valid
    FactoryBot.build(:profile, user_id: user.id, name: '12345678').should be_valid
  end

  it 'Authenticated user have one attached avatar to profile' do
    expect(Profile.new.avatar).to be_an_instance_of(ActiveStorage::Attached::One)
  end

  it 'validate avatar for profile' do
    expect(Profile.new(user_id: user.id,
                       avatar: Rack::Test::UploadedFile.new("#{Rails.root}/spec/rails_helper.rb",
                                                            'text/plain'))).to_not be_valid
    expect(Profile.new(user_id: user.id,
                       avatar: Rack::Test::UploadedFile.new("#{Rails.root}/public/avatar_default.png",
                                                            'image/png'))).to be_valid
  end
end
