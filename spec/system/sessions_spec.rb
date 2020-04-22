# frozen_string_literal: true

require 'rails_helper'
# include Warden::Test::Helpers
RSpec.describe "Sessions", type: :system do
  describe 'user_login' do
    before { sign_in }
    let(:login_user) { create :user, email: 'example@mail.com' }

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
        expect(page).to have_no_content("New")
      end
    end
  end

  describe '#tasks' do
    let(:user) { create :user, email: 'a@example.com' }

    describe 'without login' do
      context 'when trying to see tasks without login' do
        before do
          create :task, name: "taskA", user: user
          visit tasks_path
        end
        it 'disables me to see any task' do
          expect(page).to have_no_content "taskA"
          expect(current_path).to eq login_path
        end
      end
    end

    describe 'user tasks' do
      let(:login_user) { create :user, email: 'b@example.com' }
      before { sign_in }

      context 'when login userA' do
        before do
          create :task, name: "Unavailable_task", user: user
          create :task, name: "Available_task", user: login_user
          visit tasks_path
        end
        it 'disables me to see others task' do
          expect(page).to have_selector '.task_name', text: "Available_task"
          expect(page).to have_no_content "Unavailable_task"
        end
      end
    end
  end
end
