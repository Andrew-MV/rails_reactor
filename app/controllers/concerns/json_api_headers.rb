module JsonApiHeaders

  extend ActiveSupport::Concern

  def set_content_type
    response.headers['Content-Type'] = 'application/vnd.api+json'
  end

end