# frozen_string_literal: true

class Label < ApplicationRecord
  has_many :tasks_labels, dependent: :destroy
  has_many :tasks, through: :tasks_labels
  validates :name, presence: true
end
