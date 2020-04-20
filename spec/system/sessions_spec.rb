# frozen_string_literal: true

require 'rails_helper'
RSpec.describe "Sessions", type: :system do
  before { create :user, email: 'example@example.com', password: 'password' }
  describe 'user_login' do
    before do
      visit login_path
      fill_in "メールアドレス", with: 'example@example.com'
      fill_in "パスワード", with: 'password'
      click_button "Login"
    end
    context 'click the login button' do
      it "enables me to login" do
        expect(current_path).to eq tasks_path
        expect(page).to have_content("New")
      end
    end
    context 'click the logout button' do
      before { click_link "ログアウト" }
      it "enables me to logout" do
        expect(current_path).to eq login_path
      end
    end
  end
end
