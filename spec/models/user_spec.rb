require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user_1) { User.new(login: 'user1', password: 'user1') }
  let(:user_2) { User.new(login:      '', password: 'user2') }
  let(:user_3) { User.new(login: 'user3', password:      '') }
  let(:user_4) { User.create(login: 'user4', password: 'user4') }

  it { expect(user_1).to be_valid }
  it { expect(user_2).not_to be_valid }
  it { expect(user_3).not_to be_valid }

  it { expect{ user_1.save }.to change{ User.count }.by(1) }

  context 'authenticate' do
    it 'existing user' do
      user_4.save
      @user = User.authenticate('user4', 'user4')
      expect(@user.login).to eq 'user4'
    end
    it 'non-existing user' do
      @user = User.authenticate('user5', 'user5')
      expect(@user).to be_nil
    end
  end

end