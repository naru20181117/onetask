# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, length: { maximum: 20 }, presence: true
  validates :memo, length: { maximum: 100 }
  validates :end_time, presence: true

  validate :date_not_before_today

  def date_not_before_today
    errors.add(:end_time, "は明日以降のタスクを選択してください") if end_time.nil? || end_time < Time.zone.today
  end
end
