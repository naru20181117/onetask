# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, length: { maximum: 20 }, presence: true
  validates :memo, length: { maximum: 100 }

  validate :date_not_before_today

  def date_not_before_today
    if end_time.nil? || (end_time.present? && end_time < Time.zone.today)
      errors.add(:end_time, "は明日以降のタスクを選択してください")
    end
  end

  enum status: {
    Untouched: 0, WIP: 1, Done: 2
  }

  scope :search_task, ->(content) do
    if content.present?
      where("name LIKE?", "%#{content}%")
    end
  end

  scope :search_status, ->(status) do
    if status.present?
      where(status: status)
    end
  end

  include Order
end
