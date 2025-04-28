require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe "ログイン前" do
    it "ユーザー登録画面に遷移できる" do
      visit new_user_path
      expect(page).to have_content "新規登録"
    end

    it "ユーザー登録ができる" do
      visit new_user_path
      fill_in "名前", with: "Test User"
      fill_in "メールアドレス", with: "test@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード（確認）", with: "password"
      click_button "保存"
      expect(page).to have_content "確認メールを送信しました。メールアドレスを確認して下さい"
    end

    it "つかいかたにアクセスできる" do
      visit root_path
      click_link "つかいかた"

      expect(page).to have_current_path(manual_show_path, wait: 5)
      expect(page).to have_text("Manuals", wait: 5)
    end

    it "予定を立てるにアクセスできる" do
      visit root_path
      within("header") do
      click_link "予定を立てる"
      end
      expect(page).to have_content "予定を立てる"
    end

    it "プライバシーポリシーにアクセスできる" do
      visit root_path
      click_link "プライバシーポリシー"
      expect(page).to have_content "プライバシーポリシー"
    end

    it "利用規約にアクセスできる" do
      visit root_path
      click_link "利用規約"
      expect(page).to have_content "利用規約"
    end

    it "お問い合わせにアクセスできる" do
      visit root_path
      click_link "お問い合わせ"
      expect(page).to have_content "お問い合わせ"
    end

    it "githubにアクセスできる" do
      visit root_path

      new_window = window_opened_by do
        click_link "Github"
      end

      within_window new_window do
        expect(page).to have_title(/Gamers_Planner/)
      end
    end
 end

  describe "ログイン後" do
    let(:user) do
      create(:user, :activated, email: "dadatest_6@example.com")
    end

    before do
      visit new_login_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: "password"
      click_button "ログイン"
      expect(page).to have_content("ログインしました")
    end

    it "マイページにアクセスできる" do
      visit root_path
        find("#dropdownDefaultButton").click
        click_link "マイページ"
      expect(page).to have_content "予定表一覧"
    end

    it "ログアウトできる" do
      visit root_path
        find("#dropdownDefaultButton").click
        click_link "ログアウト"
      expect(page).to have_content "ログアウトしました"
    end

    it "Discordbot連携ボタンが表示される" do
      visit manual_show_path(button3: true)
      expect(page).to have_content "Bot連携"
    end
  end
end
