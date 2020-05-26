# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, length: { maximum: 20 }, presence: true
  validates :memo, length: { maximum: 100 }

  validate :date_not_before_today

  belongs_to :user
  has_many :tasks_labels, dependent: :destroy
  has_many :labels, through: :tasks_labels
  has_rich_text :content

  def date_not_before_today
    if end_time.nil? || (end_time.present? && end_time < Time.zone.today)
      errors.add(:end_time, "は明日以降のタスクを選択してください")
    end
  end

  enum status: {
    untouched: 0, wip: 1, done: 2
  }

  enum priority: {
    high: 0, medium: 1, low: 2
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

  scope :search_label, ->(label) do
    if label.present?
      joins(:labels).where('labels.id = ?', label)
    end
  end

  include Order

  def self.csv_attributes
    %w[name memo created_at updated_at end_time status priority user_id]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.find_each do |task|
        csv << csv_attributes.map { |attr| task.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      task = new
      task.attributes = row.to_hash.slice(*csv_attributes)
      task.save!
    end
  end
end
