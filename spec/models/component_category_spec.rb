require 'rails_helper'

RSpec.describe ComponentCategory, type: :model do
  it { should have_many :components }
  it { should validate_presence_of :title }
end
