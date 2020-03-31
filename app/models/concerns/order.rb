# frozen_string_literal: true

module Order
  extend ActiveSupport::Concern

  included do
    scope :select_desc, ->(sort_column) do
      order("#{sort_column} DESC")
    end
  end
end
