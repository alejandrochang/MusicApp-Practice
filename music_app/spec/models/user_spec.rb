require 'rails_helper'
#
# RSpec.describe User, type: :model do
#   # pending "add some examples to (or delete) #{__FILE__}"
# end

describe User do
  subject(:user) do
    FactoryBot.build(:user,
    email: "chang@me.com",
    password: 'the_best_password'
  )
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  # method to test is_password
  describe "#is_password?" do
    it "verifies a password is correct" do
      expect(user.is_password?('the_best_password')).to be true
    end
  end

  # method to test reset_session_token
  describe "#reset_session_token!" do
    it "gives the user a new session token" do
      user.valid?
      previous_session_token = user.session_token
      user.reset_session_token!

      expect(user.session_token).to_not eq(previous_session_token)
    end
  end

  # method to test find_by_credentials
  describe ".find_by_credentials" do
    before { user.save! }

    it "returns user given valid credentials" do
      expect(User.find_by_credentials("chang@me.com", "the_best_password")).to eq(user)
    end

    it "returns nil given incorrect credentials" do
      expect(User.find_by_credentials("chang@me.com", "bad_pass")).to eq(nil)
    end
  end
end
