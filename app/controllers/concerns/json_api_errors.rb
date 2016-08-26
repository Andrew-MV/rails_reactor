module JsonApiErrors

  extend ActiveSupport::Concern

  def to_json_api_errors(*error_types)
    # todo change statuses
    {
        errors: {
            user_exists: {
                title: 'This login is already taken or is invalid',
                status: 404
            },
            invalid_login_or_password: {
                title: 'Invalid login or password',
                status: 404
            },
            user_not_found: {
                title: 'User not found',
                status: 422
            },
            invalid_token: {
                title: 'Invalid token',
                status: 422
            },
            wrong_data: {
                title: 'Wrong data',
                status: 422
            }
        }.slice(*error_types).values.to_a
    }

  end

end