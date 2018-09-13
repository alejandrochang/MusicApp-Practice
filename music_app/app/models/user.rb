# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :email, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, :password_digest, :session_token, uniqueness: true

  attr_reader :password
  after_initialize :ensure_session_token # to ensure token is present

  def password=(password)
    @password = password
    self.password_digest = BCrypt.Password.create(password)
  end

  def is_password?(password) # check the password
    BCrypt::Password.new(self.password_digest).is_password?(password_digest)
    # know im going to call the is_password? inside
  end

  def self.generate_session_token
  end

  def self.find_by_credentials(email, password) # find by the email
    user = User.find_by(email: email)
    user && user.is_password?(password) ? user : nil
    # if we have a user, and that same user has enter the correct email
    # return the user if not nil
  end

  def reset_session_token! # how to tell if user is logged in
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def ensure_session_token # make sure that the user has session token
    self.session_token ||= SecureRandom.urlsafe_base64
    # if they don't generate one
  end
end

=begin
  Use self.password_digest to avoid issues, we cannot set @password_digest
  self.session_token = SecureRandom.urlsafe_base64 (random token)

=end
