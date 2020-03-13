# frozen_string_literal: true

require './spec/rails_helper.rb'
RSpec.describe Task do
  describe 'set_task' do
    it "is valid with a name, memo" do
      @task = Task.new(
        name: 'タスクの名前',
        memo: 'Task1',
      )
      expect(@task).to be_valid
    end

    it "is invalid without a first_name" do
      @task = Task.new(name: nil)
      expect(@task.valid?).to eq(false)
    end
  end
end
