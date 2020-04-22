# frozen_string_literal: true

module Helpers
  module Authentication
    def sign_in
      visit login_path
      fill_in "メールアドレス", with: login_user.email
      fill_in "パスワード", with: login_user.password
      click_button "Login"
    end
  end
end
