class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  has_secure_password

  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = SecureRandom.urlsafe_base64(32)
  end
end