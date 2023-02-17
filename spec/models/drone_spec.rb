require 'rails_helper'

RSpec.describe Drone, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it 'Authenticated user have many attached foto to dron-card' do
    expect(Drone.new.foto).to be_an_instance_of(ActiveStorage::Attached::One)
    expect(Drone.new.gallerys).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
end
