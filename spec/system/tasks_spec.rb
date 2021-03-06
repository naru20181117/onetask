# frozen_string_literal: true

require 'rails_helper'
RSpec.describe "Tasks", type: :system do
  let(:user_a) { create :user, name: "userA", email: 'a@example.com' }

  describe 'crud' do
    before { sign_in }
    describe '#index' do
      context 'click the home button' do
        before do
          create :task, user: user_a
          create :task, name: "second_task", user: user_a
          visit new_task_path
          click_link "One Task"
        end
        let(:login_user) { user_a }
        it "enables me to see the root path" do
          expect(current_path).to eq root_path
        end
        it 'enables me to see tasks' do
          expect(page).to have_content("hoge")
          expect(page).to have_content("second_task")
        end
      end
    end

    describe '#new' do
      before do
        create :task, user: user_a
        visit tasks_path
        find('.fa.fa-plus-circle').click
      end
      let(:login_user) { user_a }

      context "create new task with name" do
        it "enable to create one" do
          fill_in "タスク名", with: "My Task"
          fill_in "終了期限", with: Time.zone.tomorrow
          click_button "Submit"
          expect(current_path).to eq task_path(login_user.tasks.map(&:id)[-1])
          expect(page).to have_content("My Task")
          expect(page).to have_selector '.success', text: "もっとタスクを増やしていこう！"
        end
      end

      context 'create new task with name nil' do
        it "disable to create any" do
          visit tasks_path
          find('.fa.fa-plus-circle').click
          fill_in "タスク名", with: ""
          click_button "Submit"
          expect(page).to have_content("タスク名を入力してください")
          expect(page).to have_selector '.alert', text: "Task作成失敗"
        end
      end
    end

    describe '#edit' do
      let(:login_user) { user_a }
      before do
        create :task, user: user_a
        visit tasks_path
        find('.fa.fa-edit').click
      end
      context 'edit name without name' do
        it "disables me to edit task" do
          fill_in "タスク名", with: ""
          click_button "Submit"
          expect(page).to have_content("Update Your Task")
          expect(page).to have_content("error")
          expect(page).to have_selector '.alert', text: "Task変更失敗"
          expect(login_user.tasks.first.name).to have_content "hoge"
        end
      end

      context 'edit name with valid words' do
        it "enables me to edit task" do
          fill_in "タスク名", with: "Edited_Task"
          fill_in "終了期限", with: Time.zone.tomorrow
          click_button "Submit"
          expect(page).to have_content("Tasks Table")
          expect(page).to have_content("Edited_Task")
          expect(page).to have_selector '.success', text: "Task変更完了！"
        end
      end
    end

    describe '#destroy' do
      before do
        create :task, user: user_a
      end
      let(:login_user) { user_a }
      context 'click the delete button' do
        it "enables me to destroy task" do
          visit tasks_path
          expect(login_user.tasks.count).to eq 1
          find('.fa.fa-trash').click
          page.driver.browser.switch_to.alert.accept
          expect(page).not_to have_content("hoge")
          expect(login_user.tasks.count).to eq 0
        end
      end
    end
  end

  describe 'order' do
    before do
      visit login_path
      fill_in "session_email", with: login_user.email
      fill_in "session_password", with: login_user.password
      click_button "Login"
    end
    let(:login_user) { user_a }
    before { create_list :task, 3, user: user_a }
    context 'set arrangement of tasks' do
      before { visit tasks_path }
      it 'arrange the tasks order by desc' do
        task_name = all('.task_name')
        expect(task_name.map(&:text)).to eq Task.order(created_at: :desc).map(&:name)
      end
    end
  end

  describe 'end_time' do
    before { sign_in }
    describe 'validation of end_time' do
      before do
        visit tasks_path
        find('.fa.fa-plus-circle').click
        fill_in "タスク名", with: "My Task"
      end
      let(:login_user) { user_a }

      context 'the end_time is before Today' do
        it 'let you can see the zero task' do
          expect(login_user.tasks.count).to eq 0
        end
        it 'is invalid and show error' do
          fill_in "終了期限", with: Time.zone.yesterday
          click_button "Submit"
          expect(page).to have_content("は明日以降のタスクを選択してください")
          expect(login_user.tasks.count).to eq 0
        end
      end

      context 'the end_time is after Today' do
        it 'is valid' do
          expect(login_user.tasks.count).to eq 0
          fill_in "終了期限", with: Time.zone.tomorrow
          click_button "Submit"
          expect(page).to have_content(Time.zone.tomorrow.strftime("%Y/%m/%d %H:%M:%S"))
          expect(login_user.tasks.count).to eq 1
        end
      end
    end

    describe 'order by end_time' do
      context 'when click the sort pointer' do
        before { create_list :task, 3, user: user_a }
        let(:login_user) { user_a }
        it 'arrange the end_time order by desc' do
          visit tasks_path
          find('.end_pointer').click
          task_end_list = all('.task_end_time')
          end_time_array = login_user.tasks.order(end_time: :desc).map(&:end_time)
          (0..2).each do |num|
            expect(task_end_list.map(&:text)[num]).to eq end_time_array[num].strftime("%m/%d")
          end
        end
      end
    end
  end

  describe 'status' do
    before { sign_in }
    describe 'edit status' do
      let(:login_user) { user_a }
      before do
        create :task, status: "untouched", user: user_a
        visit tasks_path
      end

      context 'when click the Done button' do
        it 'changes the status Done' do
          expect(page).to have_selector '.task_status', text: "untouched"
          click_button "Done"
          expect(current_path).to eq tasks_path
          expect(page).to have_selector '.task_status', text: "done"
        end
      end

      context 'edit name with select' do
        it "enables me to edit status" do
          find('.fa.fa-edit').click
          select "wip", from: 'task[status]'
          expect(page).to have_select('task[status]', selected: 'wip')
          click_button "Submit"
          expect(page).to have_content 'wip'
          expect(page).not_to have_content "not yet"
          expect(page).to have_selector '.task_status', text: "wip"
        end
      end
    end

    describe 'validation of search method' do
      before do
        create :task, user: user_a
        visit tasks_path
      end
      let(:login_user) { user_a }

      context 'when search task name' do
        before { create :task, name: "first_task", user: user_a }
        it 'is valid to search properly' do
          fill_in 'search[content]', with: "first_task"
          click_button "検索"
          expect(page).to have_content 'first_task'
          expect(page).not_to have_content 'second_task'
        end
      end

      context 'when search Status properly' do
        it 'is valid to search properly' do
          select "untouched", from: 'search[status]'
          click_button "検索"
          expect(page).to have_selector '.task_status', text: 'untouched'
          expect(page).not_to have_selector '.task_status', text: 'wip'
        end
      end

      context 'when search task name and Status properly' do
        before do
          create :task, name: "first_task", status: "untouched", user: user_a
          create :task, name: "first_task[A]", status: "done", user: user_a
        end
        it 'is valid to search them properly' do
          fill_in 'search[content]', with: "first_task"
          select "untouched", from: 'search[status]'
          click_button "検索"
          expect(page).to have_selector '.task_name', text: 'first_task'
          expect(page).not_to have_selector '.task_name', text: 'first_task[A]'
        end
      end
    end

    describe 'validation of priority method' do
      let(:login_user) { user_a }
      context 'when click the sort pointer' do
        before do
          visit tasks_path
          create :task, priority: "low", user: user_a
          create :task, priority: "medium", user: user_a
          create :task, priority: "high", user: user_a
        end
        it 'arrange the priority order by desc' do
          find('.priority_pointer').click
          task_priority = all('.task_priority')
          expect(task_priority.map(&:text)).to eq Task.order(priority: :desc).map(&:priority)
        end
      end
    end

    describe 'validation of priority method' do
      let(:login_user) { user_a }
      context 'when click the sort pointer' do
        before do
          visit tasks_path
          create :task, priority: "low", user: user_a
          create :task, priority: "medium", user: user_a
          create :task, priority: "high", user: user_a
        end
        it 'arrange the priority order by desc' do
          find('.priority_pointer').click
          task_priority = all('.task_priority')
          expect(task_priority.map(&:text)).to eq Task.order(priority: :desc).map(&:priority)
        end
      end
    end

    describe 'validation of pagination method' do
      let(:login_user) { user_a }
      before do
        create_list :task, 15, user: user_a
        visit tasks_path
      end
      context 'when you can see the pagination' do
        it 'can be seen the page less than 6 itmes' do
          expect(all('.task_name').count).to eq 6
        end
      end
    end
  end
end
