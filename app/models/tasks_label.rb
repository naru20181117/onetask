# frozen_string_literal: true

class TasksLabel < ApplicationRecord
  belongs_to :task
  belongs_to :label
end
