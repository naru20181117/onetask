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
        expect(task.errors[:name]).to include("can't be blank")
      end
    end
    context "when the memo has more than 100 letters" do
      let(:task) { build :task, memo: "a" * 101 }
      it { is_expected.to be_invalid }
    end
  end
end
