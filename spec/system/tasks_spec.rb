# frozen_string_literal: true

require 'rails_helper'
RSpec.describe "Tasks", type: :system do
  describe 'crud' do
    describe '#index' do
      it "enables me to see" do
        visit tasks_path
        click_link "One Task"
        expect(page).to have_content("Tasks Table")
      end
    end

    describe '#new' do
      context "enable" do
        it "create new task" do
          visit new_task_path
          fill_in "Name", with: "My Task"
          click_button "Submit"
          expect(page).to have_content("Your Task")
          expect(page).to have_content("My Task")
          expect(page).to have_selector '.success', text: "もっとタスクを増やしていこう！"
        end
      end
      context 'disable' do
        it "create new task" do
          visit new_task_path
          fill_in "Name", with: ""
          click_button "Submit"
          expect(page).to have_content("Name can't be blank")
          expect(page).to have_selector '.alert', text: "Task名を確認して！"
        end
      end
    end

    describe '#edit' do
      let!(:task) { create :task }
      it "enables me to edit task" do
        visit edit_task_path(task)
        fill_in "Name", with: "Edited_Task"
        click_button "Submit"
        expect(page).to have_content("Tasks Table")
        expect(page).to have_content("Edited_Task")
        expect(page).to have_selector '.success', text: "Task変更完了！"
      end

      it "disables me to edit task" do
        visit edit_task_path(task)
        fill_in "Name", with: ""
        click_button "Submit"
        expect(page).to have_content("Update Your Task")
        expect(page).to have_content("error")
        expect(page).to have_selector '.alert', text: "Task変更失敗"
      end
    end

    describe '#destroy' do
      let!(:task) { create :task }
      it "enables me to destroy task" do
        visit tasks_path
        click_button "Delete"
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content("hoge")
        expect(page).to have_selector '.notice', text: "Deleted the task"
      end
    end
  end
end
