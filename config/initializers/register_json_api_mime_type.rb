api_mime_types = %W(
  application/vnd.api+json
)

Mime::Type.unregister :json
Mime::Type.register 'application/json', :json, api_mime_types