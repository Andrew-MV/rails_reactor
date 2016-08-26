class User < ActiveRecord::Base
  validates :login, presence: :true, uniqueness: :true
  validates :password, presence: :true

  include JsonApiSchema

  def authorization_token
    "#{self.id}_#{self.login}"
  end

  def json_api_schema_attributes
    {
        login: self.login
    }
  end

end