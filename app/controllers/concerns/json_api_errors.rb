module JsonApiErrors

  extend ActiveSupport::Concern

  def to_json_api_errors(*error_types)
    {
        errors: {
            user_exists: {
                title: 'This login is already taken or is invalid',
                status: 400
            },
            invalid_login_or_password: {
                title: 'Invalid login or password',
                status: 400
            },
            user_not_found: {
                title: 'User not found',
                status: 404
            },
            invalid_token: {
                title: 'Invalid token',
                status: 400
            },
            wrong_data: {
                title: 'Wrong data',
                status: 400
            }
        }.slice(*error_types).values.to_a
    }

  end

end