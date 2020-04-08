# frozen_string_literal: true

require './spec/rails_helper.rb'
RSpec.describe Task do
  subject { task }
  describe 'valid_task' do
    context "when the name is less than 20 letters" do
      let(:task) { build :task, name: "a" * 20 }
      it { is_expected.to be_valid }
    end
    context "when the memo is less than 100 letters" do
      let(:task) { build :task, memo: "a" * 100 }
      it { is_expected.to be_valid }
    end
  end

  describe 'invalid_task' do
    context "when the name has more than 20 letters" do
      let(:task) { build :task, name: "a" * 21 }
      it { is_expected.to be_invalid }
    end
    context 'when the name is nil' do
      let(:task) { build :task, name: nil }
      it "is invalid" do
        is_expected.to be_invalid
        expect(task.errors[:name]).to end_with("を入力してください")
      end
    end
    context "when the memo has more than 100 letters" do
      let(:task) { build :task, memo: "a" * 101 }
      it { is_expected.to be_invalid }
    end
  end

  describe 'valid_end_time' do
    context "when the end_time is after today" do
      let(:task) { build :task, end_time: Time.zone.tomorrow }
      it { is_expected.to be_valid }
    end
  end
  describe 'invalid_end_time' do
    subject { task.errors[:end_time] }
    context "when the end_time is before or just today" do
      let(:task) { build :task, end_time: Time.zone.today }
      it "is invalid" do
        expect(task).to be_invalid
        is_expected.to end_with("は明日以降のタスクを選択してください")
      end
    end
    context 'when the end_tume is nil' do
      let(:task) { build :task, end_time: nil }
      it "is invalid" do
        expect(task).to be_invalid
        is_expected.to end_with("は明日以降のタスクを選択してください")
      end
    end
  end
  describe 'valid_status' do
    context "when the status is nil" do
      let(:task) { build :task }
      it "is set to the default" do
        expect(task.status).to eq "untouched"
      end
    end
  end
  describe 'valid_priority' do
    context "when the priority is nil" do
      let(:task) { build :task }
      it "is set to the default" do
        expect(task.priority).to eq "low"
      end
    end
  end
end
