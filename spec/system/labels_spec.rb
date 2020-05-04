# frozen_string_literal: true

require 'rails_helper'
RSpec.describe "Labels", type: :system do
  let(:login_user) { create :user }
  before do
    sign_in
    create :task, :task_with_labels, user: login_user
    visit tasks_path
  end
  describe '#new' do
    before do
      click_link "New"
    end
    context "create new task with labels" do
      it "enable to create one" do
        fill_in "タスク名", with: "My Task"
        fill_in "終了期限", with: Time.zone.tomorrow
        check "HTML"
        click_button "Submit"
        expect(current_path).to eq task_path(login_user.tasks.map(&:id)[-1])
        expect(page).to have_content("Your Task")
        expect(page).to have_selector '.badge', text: "HTML"
      end
    end
  end

  describe '#edit' do
    before do
      create :label, :label_css
      find('.fa.fa-edit').click
    end
    context 'edit tasks label' do
      it "ables me to edit label" do
        check "CSS"
        click_button "Submit"
        expect(current_path).to eq tasks_path
        expect(page).to have_selector '.success', text: "Task変更完了！"
        expect(page).to have_selector '.badge', text: "CSS"
      end
    end
  end

  describe 'search label method' do
    let!(:task_css) { create :task, user: login_user }
    let!(:task_js) { create :task, user: login_user }
    let(:css) { create :label, :label_css }
    let(:js) { create :label, :label_js }
    before do
      task_css.labels << css
      task_js.labels << js
      visit tasks_path
    end
    context 'when search label name' do
      it 'is valid to search properly' do
        expect(page).to have_selector '.badge', text: "HTML"
        select "CSS", from: 'search[label]'
        expect(page).to have_select('search[label]', selected: 'CSS')
        click_button "検索"
        expect(page).to have_selector '.task_name', text: task_css.name
        expect(page).not_to have_selector '.task_name', text: task_js.name
      end
    end
  end
end
