# frozen_string_literal: true

require 'rails_helper'
RSpec.describe "Users", type: :system do
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

  describe 'user tasks' do
    before do
      visit login_path
      fill_in "メールアドレス", with: login_user.email
      fill_in "パスワード", with: login_user.password
      click_button "Login"
    end

    let(:user_a) { create :user, email: 'a@example.com' }
    let(:user_b) { create :user, email: 'b@example.com' }
    context 'when login userA' do
      before do
        create :task, name: "taskA", user: user_a
        create :task, name: "taskB", user: user_b
        visit tasks_path
      end
      let(:login_user) { user_b }
      it 'disables me to see others task' do
        expect(page).to have_selector '.task_name', text: "taskB"
        expect(page).to have_no_content "taskA"
      end
    end
  end
end
