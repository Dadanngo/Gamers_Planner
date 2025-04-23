require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  describe "ログイン前" do
    it "ユーザー登録画面に遷移できる" do
      visit new_user_path
      expect(page).to have_content "ユーザー登録"
    end
    it "ユーザー登録ができる" do
      visit new_user_path
      fill_in "名前", with: "Test User"
      fill_in "メールアドレス", with: "test@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード確認", with: "password"
      click_button "保存"
      expect(page).to have_content "確認メールを送信しました"
    end
  end
end
