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
end
