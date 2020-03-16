# frozen_string_literal: true

require './spec/rails_helper.rb'
RSpec.describe Task do
  describe 'valid_task' do
    context "when the name is less than 20 letters" do
      let(:task) { build :task, name: "#{'a' * 15}.to_s" }
      it "is valid" do
        expect(task).to be_valid
      end
    end
    context "when the memo is less than 100 letters" do
      let(:task) { build :task, memo: "#{'a' * 95}.to_s" }
      it "is valid" do
        expect(task).to be_valid
      end
    end
  end

  describe 'invalid_task' do
    context "when the name has more than 20 letters" do
      let(:task) { build :task, name: "#{'a' * 16}.to_s" }
      it "is in_valid" do
        expect(task).to be_invalid
      end
    end
    context 'when the name is nil' do
      let(:task) { build :task, name: nil }
      it "is invalid" do
        expect(task).to be_invalid
        expect(task.errors[:name]).to include("can't be blank")
      end
    end
    context "when the memo has more than 100 letters" do
      let(:task) { build :task, memo: "#{'a' * 96}.to_s" }
      it "is valid" do
        expect(task).to be_invalid
      end
    end
  end
end
