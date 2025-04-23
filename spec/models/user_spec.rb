require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    it '名前が空の場合、無効であること' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'メールアドレスが空の場合、無効であること' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'passwordが空の場合、無効であること' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it 'password_confirmationが空の場合、無効であること' do
      user = build(:user, password_confirmation: nil)
      expect(user).not_to be_valid
    end

    it 'passwordとpassword_confirmationが一致しない場合、無効であること' do
      user = build(:user, password: 'password', password_confirmation: 'different_password')
      expect(user).not_to be_valid
    end
  end
end
