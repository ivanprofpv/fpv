require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:voter) { create(:user) }
  let(:voter2) { create(:user) }
  let(:drone) { create(:drone, user:) }
  let(:votable) { create(:comment, drone:, user: voter) }

  it { should belong_to :drone }
  it { should belong_to :user }

  it { should validate_presence_of :body }

  it 'should be votable' do
    expect(Comment).to be_votable
  end

  it 'should be voted on after a voter has voted' do
    votable.vote_by(voter:)
    expect(voter.voted_on?(votable)).to be true
    expect(voter.voted_for?(votable)).to be true
  end

  it 'should not be voted on if a voter has not voted' do
    expect(voter.voted_on?(votable)).to be false
  end

  it 'should allow the voter to vote up a model' do
    voter.vote_up_for votable
    expect(votable.get_up_votes.first.voter).to eq(voter)
    expect(votable.votes_for.up.first.voter).to eq(voter)
  end

  it 'should get all of the voters up votes' do
    voter.vote_up_for votable
    expect(voter.find_up_votes.size).to eq(1)
    expect(voter.votes.up.count).to eq(1)
  end

  it 'should allow the voter to unvote a model' do
    voter.vote_up_for votable
    voter.unvote_for votable
    expect(votable.find_votes_for.size).to eq(0)
    expect(votable.votes_for.count).to eq(0)
  end

  it 'should have 2 votes_for when voted on once by two different people' do
    votable.vote_by(voter:)
    votable.vote_by voter: voter2
    expect(votable.votes_for.size).to eq(2)
  end
end
