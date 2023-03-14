require 'rails_helper'

RSpec.describe Component, type: :model do
  let(:user) { create(:user) }
  let(:component_category) { create(:component_category) }
  let(:drone) { create(:drone, user: user) }

  it { should belong_to :drone }
  it { should belong_to :component_category }

  it { should validate_presence_of :title }
  it { should validate_presence_of :component_category_id }
  it { should allow_value('http://ya.ru').for(:url ) }

  it "validates title length" do
    FactoryBot.build(:component, drone: drone, title: "123456789101234567891012345678910", component_category: component_category).should_not be_valid
    FactoryBot.build(:component, drone: drone, component_category: component_category, title: "12345678").should be_valid
  end

  it "validates price length" do
    FactoryBot.build(:component, drone: drone, price: "1234567", component_category: component_category).should_not be_valid
    FactoryBot.build(:component, drone: drone, price: "1234", component_category: component_category).should be_valid
  end
end
