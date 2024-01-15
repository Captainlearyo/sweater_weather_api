require 'securerandom'

class User < ApplicationRecord
  has_secure_password
  
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  before_validation :generate_api_key
  validates :api_key, uniqueness: true, presence: true

  

  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = SecureRandom.base64
  end
end