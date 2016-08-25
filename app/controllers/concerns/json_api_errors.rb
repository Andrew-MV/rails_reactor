module JsonApiErrors

  extend ActiveSupport::Concern

  def to_json_api_errors(*error_types)
    # todo change statuses
    {
        errors: {
            user_exists: {
                title: 'User already exists',
                status: 404
            },
            invalid_login_or_password: {
                title: 'Invalid login or password',
                status: 404
            }
            # error_3: {
            #     title: 'User not found_3',
            #     status: 404
            # },
        }.slice(*error_types).values.to_a
    }

  end

end