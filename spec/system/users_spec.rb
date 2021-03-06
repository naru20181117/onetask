# frozen_string_literal: true

require 'rails_helper'
RSpec.describe "Users", type: :system do
  describe 'login method' do
    before { sign_in }
    let(:login_user) { create :user, email: "example@example.com" }
    describe '#crud' do
      before { visit admin_users_path }
      describe '#index' do
        context 'click the All user link' do
          before do
            create :user, name: 'UserA'
            click_link "All User"
          end
          it "enables me to see the User Table page" do
            expect(current_path).to eq admin_users_path
          end
          it 'enables me to see User' do
            expect(page).to have_content("UserA")
          end
        end

        context 'create users tasks' do
          before do
            create :task, user: login_user
            create :task, user: login_user
            create :task, user: login_user
          end
          it "enables me to see the User tasks number" do
            visit admin_users_path
            expect(page).to have_selector '.tasks_number', text: '3'
            expect(current_path).to eq admin_users_path
          end
        end
      end

      describe '#show' do
        before { create :task, name: "Seen Task", user: login_user }
        context 'click users id' do
          it 'can see the task description' do
            click_link login_user.id
            expect(current_path).to eq admin_user_path(login_user.id)
            expect(page).to have_content("Seen Task")
          end
        end
      end

      describe '#new' do
        before { click_link "新規登録" }
        context "create new User with name" do
          subject do
            fill_in "ユーザー名", with: "Created User"
            fill_in "メールアドレス", with: "example0@example.com"
            fill_in "パスワード", with: "password"
            fill_in "確認用パスワード", with: "password"
            click_button "Submit"
          end
          it "enable to see changed user count" do
            expect { subject }.to change { User.count }.from(1).to(2)
          end
          it "enable to create one" do
            subject
            expect(current_path).to eq admin_users_path
            expect(page).to have_content("Users Table")
            expect(page).to have_selector '.success', text: "を登録しました。"
          end
        end

        context 'create new User with name nil' do
          it "disable to create any" do
            fill_in "ユーザー名", with: ""
            fill_in "メールアドレス", with: "example1@example.com"
            fill_in "パスワード", with: "password"
            fill_in "確認用パスワード", with: "password"
            click_button "Submit"
            expect(page).to have_content("Create User")
            expect(page).to have_selector '.error', text: "ユーザー名を入力してください"
          end
        end

        context 'create new User with email nil' do
          it "disable to create any" do
            fill_in "ユーザー名", with: "User Name"
            fill_in "メールアドレス", with: ""
            fill_in "パスワード", with: "password"
            fill_in "確認用パスワード", with: "password"
            click_button "Submit"
            expect(page).to have_content("Create User")
            expect(page).to have_selector '.error', text: "メールアドレスを入力してください"
          end
        end

        context 'create new User with email nil' do
          it "disable to create any" do
            fill_in "ユーザー名", with: "User Name"
            fill_in "メールアドレス", with: "example@example.com"
            fill_in "パスワード", with: "password"
            fill_in "確認用パスワード", with: "password"
            click_button "Submit"
            expect(page).to have_content("Create User")
            expect(page).to have_selector '.error', text: "メールアドレスはすでに存在します"
          end
        end

        context 'create new User with invalid email form' do
          it "disable to create any" do
            fill_in "ユーザー名", with: "User Name"
            fill_in "メールアドレス", with: "aaaaaa"
            fill_in "パスワード", with: "password"
            fill_in "確認用パスワード", with: "password"
            click_button "Submit"
            expect(page).to have_content("Create User")
            expect(page).to have_selector '.error', text: "メールアドレスは不正な値です"
          end
        end

        context 'create new User with password nil' do
          it "disable to create any" do
            fill_in "ユーザー名", with: "User Name"
            fill_in "メールアドレス", with: "example2@example.com"
            fill_in "パスワード", with: ""
            fill_in "確認用パスワード", with: "password"
            click_button "Submit"
            expect(page).to have_content("Create User")
            expect(page).to have_selector '.error', text: "パスワードを入力してください"
          end
        end

        context 'create new User with password_confrimation nil' do
          it "disable to create any" do
            fill_in "ユーザー名", with: "User Name"
            fill_in "メールアドレス", with: "example3@example.com"
            fill_in "パスワード", with: "password"
            fill_in "確認用パスワード", with: ""
            click_button "Submit"
            expect(page).to have_content("Create User")
            expect(page).to have_selector '.error', text: "確認用パスワードとパスワードの入力が一致しません"
          end
        end
      end

      describe '#edit' do
        before do
          create :user
          first('.fa.fa-edit').click
        end
        context 'edit name without name' do
          it "disables me to edit task" do
            fill_in "ユーザー名", with: ""
            click_button "Submit"
            expect(page).to have_content("Edit User")
            expect(page).to have_selector '.error', text: "ユーザー名を入力してください"
          end
        end

        context 'edit name with valid words' do
          it "enables me to edit task" do
            fill_in "ユーザー名", with: "Edited_User"
            click_button "Submit"
            expect(page).to have_content("User Page")
            expect(page).to have_content("Edited_User")
            expect(page).to have_selector '.success', text: "を更新しました。"
          end
        end
      end

      describe '#destroy' do
        before do
          create :user, name: "delete_user"
          visit admin_users_path
        end
        context 'click the delete button' do
          it "enables me to destroy task" do
            expect(page).to have_content("delete_user")
            first('.fa.fa-trash').click
            page.driver.browser.switch_to.alert.accept
            expect(current_path).to eq admin_users_path
          end
        end
      end
    end

    describe 'order' do
      before do
        create_list :user, 3
        visit admin_users_path
      end
      context 'set arrangement of users' do
        it 'arrange the tasks order by desc' do
          user_name = all('.user_name')
          expect(user_name.map(&:text)).to eq User.order(created_at: :desc).map(&:name)
        end
      end
    end
  end

  describe '#admin' do
    before { sign_in }
    let(:login_user) { create :user, admin: false }
    context 'connet User index without admin right' do
      before { visit admin_users_path }
      it 'makes you see the error page' do
        expect(page).not_to have_content("Users Table")
        expect(page).to have_content("403 Forbidden")
      end
    end
    context 'connet User new without admin right' do
      before { visit new_admin_user_path }
      it 'makes you see the error page' do
        expect(page).not_to have_content("Users Table")
        expect(page).to have_content("403 Forbidden")
      end
    end
    context 'connet error page and click button' do
      before { visit admin_users_path }
      it 'makes you see the tasks page' do
        click_link 'Taskページへ戻る'
        expect(current_path).to eq tasks_path
        expect(page).to have_content("Tasks Table")
      end
    end
    context 'without admin right' do
      it 'disables me to see User page link' do
        expect(page).not_to have_content("All User")
      end
    end
  end
end
