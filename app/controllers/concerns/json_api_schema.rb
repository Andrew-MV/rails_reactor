module JsonApiSchema

  extend ActiveSupport::Concern

  def to_json_api_schema(meta = {})

    schema = {
        data: {
            id: self.id,
            type: self.model_name.plural,
            attributes: self.respond_to?('json_api_schema_attributes') ? self.send('json_api_schema_attributes') : {}
        }
    }

    schema[:meta] = meta unless meta.empty?

    schema

  end

end