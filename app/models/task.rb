# frozen_string_literal: true

class Task < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  validates :name, length: { maximum: 20 }, presence: true
  validates :memo, length: { maximum: 100 }
end
