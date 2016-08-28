require 'rails_helper'

RSpec.describe AuthorizationController, type: :controller do

  let(:user_1) { User.new(login: 'user1', password: 'user1'    ) }
  let(:user_2) { User.new(login: 'user1', password: 'different') }
  let(:user_3) { User.new(login:      '', password: 'user1'    ) }
  let(:user_4) { User.new(login: 'userN', password: 'different') }

  def params(user)
    {
        meta: {
            login:    user.login,
            password: user.password
        }
    }
  end

  context 'sign up' do
    it 'should be successful' do
      post :sign_up, params(user_1), format: :json
      expect(response).to be_success
    end

  end

  context 'sign in' do

    context 'should fail for' do
      it 'user with empty login' do
        post :sign_up, params(user_3), format: :json
        expect(response).to be_bad_request
      end

    end
  end

end
