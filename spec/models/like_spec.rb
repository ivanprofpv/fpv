require 'rails_helper'

RSpec.describe Like, type: :model do
  it { should belong_to :user }
  it { should belong_to :likeable }

  let(:author) { create(:user) }
  let(:likeable) { create(:drone, user: author) }

  describe 'Author cannot vote on their own drone' do 
    it 'error when trying to like' do 
      like = described_class.new(user_id: author.id, likeable: likeable, like_weight: 1)
      like.valid?
      expect(like.errors[:user]).to include("You can't like your own build")
    end
  end
end
