# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, length: { maximum: 20 }, presence: true
  validates :memo, length: { maximum: 100 }
  validates :end_time, presence: true

  validate :date_not_before_today

  def date_not_before_today
    unless end_time.nil?
      errors.add(:end_time, "は明日以降のタスクを選択してください") if end_time < Time.zone.today
    end
  end

  scope :desc_end_time, -> { order("tasks.end_time DESC") }
  scope :desc_created_at, -> { order("tasks.created_at DESC") }
  def self.create_order
    # if @created_at_num == 0
    #   @tasks = Task.order(created_at: :DESC)
    #   @created_at = '登録日時▼'
    #   puts "チェック！！！！！！！！！！！！！！"
    #   @created_at_num = 1
    # else
    #   # @tasks = Task.order(created_at: :ASC)
    #   # @created_at = '登録日時▲'
    #   @created_at_num = 0
    # end
  end

  def self.end_order
    # if @end_time_num == 0
    #   # @tasks = Task.order(end_time: :DESC)
    #   @end_time = '終了期限▼'
    #   @end_time_num = 1
    # else
    #   # @tasks = Task.order(end_time: :ASC)
    #   @end_time = '終了期限▲'
    #   @end_time_num = 0
    # end
  end

end
