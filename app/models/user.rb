require 'bcrypt'

class User < ActiveRecord::Base

  attr_accessor :password
  before_save :encrypt_password

  validates :login, presence: :true, uniqueness: :true
  validates :password, presence: :true

  include JsonApiSchema

  def authorization_token
    "#{self.id}_#{self.login}"
  end

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def self.authenticate(login, password)
    user = find_by(login: login)
    (user && user.password_hash == BCrypt::Engine.hash_secret(password, user.salt)) ? user : nil
  end

  def json_api_schema_attributes
    {
        login: self.login
    }
  end

end