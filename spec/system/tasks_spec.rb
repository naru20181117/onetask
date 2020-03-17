# frozen_string_literal: true

require 'rails_helper'
RSpec.describe "Tasks", type: :system do
  describe 'crud' do
    describe '#index' do
      context 'click the home button' do
        before do
          create :task
          create :task, name: "second_task"
        end
        it "enables me to see home" do
          visit new_task_path
          click_link "One Task"
          expect(current_path).to eq root_path
          expect(page).to have_content("Tasks Table")
          expect(page).to have_content("hoge")
          expect(page).to have_content("second_task")
        end
      end
    end

    describe '#new' do
      before do
        visit tasks_path
        click_link "New"
      end
      context "create new task with name" do
        it "enable to create one" do
          fill_in "タスク名", with: "My Task"
          click_button "Submit"
          expect(current_path).to eq task_path(Task.ids)
          expect(page).to have_content("Your Task")
          expect(page).to have_content("My Task")
          expect(page).to have_selector '.success', text: "もっとタスクを増やしていこう！"
        end
      end
      context 'create new task with name nil' do
        it "disable to create any" do
          fill_in "タスク名", with: ""
          click_button "Submit"
          expect(page).to have_content("タスク名を入力してください")
          expect(page).to have_selector '.alert', text: "Task名を確認して！"
        end
      end
    end

    describe '#edit' do
      let!(:task) { create :task }
      before do
        visit tasks_path
        click_link "Edit"
      end
      context 'edit name with valid words' do
        it "enables me to edit task" do
          fill_in "タスク名", with: "Edited_Task"
          click_button "Submit"
          expect(page).to have_content("Tasks Table")
          expect(page).to have_content("Edited_Task")
          expect(page).to have_selector '.success', text: "Task変更完了！"
        end
      end
      context 'edit name without name' do
        it "disables me to edit task" do
          fill_in "タスク名", with: ""
          click_button "Submit"
          expect(page).to have_content("Update Your Task")
          expect(page).to have_content("error")
          expect(page).to have_selector '.alert', text: "Task変更失敗"
          expect(task.name).to eq "hoge"
        end
        let!(:task) { create :task }
        it "enables me to edit task" do
          visit edit_task_path(task)
          fill_in "タスク名", with: "Edited_Task"
          click_button "Submit"
          expect(page).to have_content("Tasks Table")
          expect(page).to have_content("Edited_Task")
          expect(page).to have_selector '.success', text: "Task変更完了！"
        end

        it "disables me to edit task" do
          visit edit_task_path(task)
          fill_in "タスク名", with: ""
          click_button "Submit"
          expect(page).to have_content("Update Your Task")
          expect(page).to have_content("error")
          expect(page).to have_selector '.alert', text: "Task変更失敗"
        end
      end
    end

    describe '#destroy' do
      context 'click the delete button' do
        let!(:task) { create :task }
        it "enables me to destroy task" do
          visit tasks_path
          expect(Task.count).to eq 1
          click_button "Delete"
          page.driver.browser.switch_to.alert.accept
          expect(page).not_to have_content("hoge")
          expect(page).to have_selector '.notice', text: "Deleted the task"
          expect(Task.count).to eq 0
        end
      end
    end
  end
  describe 'order' do
    before do
      create :task, id: 1, name: 'new1'
      create :task, id: 2, name: 'new2', created_at: Time.current + 2.hours
      create :task, id: 3, name: 'new3', created_at: Time.current + 1.hour
      visit tasks_path
    end
    it 'arrange the tasks order by desc' do
      task_list = all('.task_line')
      expect(task_list[0]).to have_content("new2")
      expect(task_list[1]).to have_content("new3")
      expect(task_list[2]).not_to have_content("new3")
    end
  end
end
