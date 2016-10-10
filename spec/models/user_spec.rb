require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    FactoryGirl.create(:user)
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_uniqueness_of(:password_digest) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6)}
  end

  describe "associations" do
    it { should have_many(:goals) }
  end

  describe "methods" do
    describe "::find_by_credentials" do
      context "when given valid credentials" do
        it "returns the correct user" do
          username = User.first.name
          expect(User.find_by_credentials(username, "testtest")).to eq(User.first)
        end
      end

      context "when given invalid credentials" do
        it "returns nil" do
          username = User.first.name
          expect(User.find_by_credentials(username, "testtes")).to be_nil
        end
      end
    end
  end
end
