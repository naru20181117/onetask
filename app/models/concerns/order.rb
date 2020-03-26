# frozen_string_literal: true

module Order
  extend ActiveSupport::Concern

  included do
    scope :select_desc, ->(created_at, end_time) do
      if created_at.present?
        order(created_at: :DESC)
      elsif end_time.present?
        order(end_time: :DESC)
      else
        order(created_at: :DESC)
      end
    end
  end
end
