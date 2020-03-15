# frozen_string_literal: true

require './spec/rails_helper.rb'
RSpec.describe Task do
  describe 'valid_task' do
    let!(:task) { build :task }
    it "is valid with a name, memo" do
      expect(task).to be_valid
    end
  end

  describe 'invalid_task' do
    let!(:task) { build :task, name: nil }
    it "is invalid with a wrong name" do
      expect(task).to be_invalid
      expect(task.errors[:name]).to include("can't be blank")
    end
  end
end
