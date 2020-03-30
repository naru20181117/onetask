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

  scope :search, ->(model, content) do
    if content.present?
      if model == 'task'
        where("name LIKE?", "%#{content}%")
      elsif model == 'status'
        where("status LIKE?", "%#{content}%")
      end
    else
      where("name LIKE?", "%%")
    end
  end

  include Order
end
